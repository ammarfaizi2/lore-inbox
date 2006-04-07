Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWDGVuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWDGVuf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWDGVuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:50:35 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:29830 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964979AbWDGVuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:50:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=K0YoCyZAYjK6onV3VdXmnwSljnI6nmXl4xFY26nybS9XALMYzVjbed9NQ3xGMwyn6SFIcqSWzmYPg2XvZn0rP6Ig2qISuV7k2YT9J4i/Badl4HuPB7oQrvuJJGKnozHiV7ZyQrFJG5WPcwOdr+IrFbCX1PPHvohZpArzqaNrlkM=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 08/17] uml: prepare fixing compilation output
Date: Fri, 7 Apr 2006 23:50:32 +0200
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20060407142709.19201.99196.stgit@zion.home.lan> <20060407143107.19201.23684.stgit@zion.home.lan> <20060407160540.GB4962@ccure.user-mode-linux.org>
In-Reply-To: <20060407160540.GB4962@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072350.33176.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 18:05, Jeff Dike wrote:
> On Fri, Apr 07, 2006 at 04:31:08PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > Move the build of user-offsets to arch/um/Kbuild, this will allow using
> > the normal user-objs machinery. I had written this to fixup for a Kbuild
> > change, but another fix was merged. This is still useful however.

> What's the benefit of this?
Er, just a style issue - or now it's a little cleanup just for style - I've 
thought to merge it anyway, even if I haven't converted it to a standard 
rule.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
