Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbVI1MPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVI1MPy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 08:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVI1MPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 08:15:54 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:45212 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750889AbVI1MPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 08:15:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ILp/vvQIiA/XFH8fQMfFjVFpoJYp7drVc0AhrydI9b72ujeoaARsztX4bJcrKM+zxQs+RkCQg5AnGqPSGBEQUMouRA45Ii4wM4+Lt9QQm8vLDBoFQrNZVO2yAMdHV15J4YiF9Ek5lu7q3axQRQw+o0hw2MeO7c8YS9UXIbohNvg=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Uml showstopper bugs for 2.6.14
Date: Wed, 28 Sep 2005 14:15:18 +0200
User-Agent: KMail/1.8.2
Cc: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200509271846.51804.blaisorblade@yahoo.it> <20050927193055.GA30451@ccure.user-mode-linux.org>
In-Reply-To: <20050927193055.GA30451@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281415.18586.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 September 2005 21:30, Jeff Dike wrote:
> On Tue, Sep 27, 2005 at 06:46:50PM +0200, Blaisorblade wrote:
> > Jeff, have you any further notes to add?
>
> Agree.
>
> I have one more to add - that UML/x86_64 doesn't run with
> CONFIG_FRAME_POINTER disabled.
Do you know when this was introduced, and the last working UML version?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
