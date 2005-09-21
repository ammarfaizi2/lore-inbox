Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbVIUPU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVIUPU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVIUPU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:20:29 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:25515 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751036AbVIUPU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:20:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=53gZXE/AHYFM+3xl2oYM6mmd7zZgFVyjyfjC7zr07+y4Q4lLuKnP4c30eRj/UTaEY/ISeajXsILyswWCf3r1XWdHgn3+pKVxFvGq95kZcgFlfwwsyx/GwsB6iM/W7dNCSlRcnwJJqRgkmi9DRWUHY7ox3ybPF0DgLZxR2/nkOe4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Nix <nix@esperi.org.uk>
Subject: Re: [PATCH 1/7] Add dm-snapshot tutorial in Documentation
Date: Wed, 21 Sep 2005 17:04:14 +0200
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050920184513.14557.8152.stgit@zion.home.lan> <874q8f5qw1.fsf@amaterasu.srvr.nix>
In-Reply-To: <874q8f5qw1.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211704.15364.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 00:13, Nix wrote:
> On 20 Sep 2005, Paolo Giarrusso docced:
> > +When you create a LVM* snapshot of a volume, four dm devices are used:
>
> [...]
>
> > +* I've verified this with LVM 2.01.09, however I assume this is the LVM2
> > way +  of doing this.

> Yes; LVM1 doesn't use device-mapper at all, so these docs don't apply to
> it.
I really meant "I assume that all LVM2 releases work this way".
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
