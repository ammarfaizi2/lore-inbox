Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161272AbVIPTGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161272AbVIPTGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161273AbVIPTGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:06:50 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:63670 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161272AbVIPTGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:06:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=589bqg/fnZtbo2LOVm9/G1BCy6KlcBdViAdc42VJCaeviCliwy5gLm8OLMOdF8XKLDtGR7K8jcmF/3E4DLKjoM/qBqSZZaSp6c8nr/Qk98nVkUGxjP80+DtlTHZ5hmNyIssAP9vcthtMVBTT1zRcCNsg4uKy0T5i6hTastwA5dk=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 1/10] UML - _switch_to code consolidation
Date: Fri, 16 Sep 2005 20:55:08 +0200
User-Agent: KMail/1.8.1
Cc: Pavel Machek <pavel@suse.cz>, Jeff Dike <jdike@addtoit.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <200509142155.j8ELtm5c012124@ccure.user-mode-linux.org> <20050915095828.GE7880@elf.ucw.cz>
In-Reply-To: <20050915095828.GE7880@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509162055.08876.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 September 2005 11:58, Pavel Machek wrote:
> Hi!
>

> I sense a whitespace damage here.
Yes, it seems definitely that getting Jeff to use tabs consistently is a 
daunting task, since when he started removing the Emacs annotations from the 
files.

Apart for parentheses excess in return and missing spaces with if and such...

Jeff, have you moved that to your emacs settings or not yet?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
