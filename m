Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUAVNab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 08:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266259AbUAVNaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 08:30:30 -0500
Received: from ofmail.of.pl ([217.97.243.238]:19675 "EHLO ofmail.of.pl")
	by vger.kernel.org with ESMTP id S266256AbUAVNa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 08:30:26 -0500
From: =?iso-8859-2?q?Pawe=B3_Goleniowski?= <pawelg@dabrowa.pl>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Re: [PATCH] rivafb & small 16 bit mode problem
Date: Thu, 22 Jan 2004 14:30:52 +0100
User-Agent: KMail/1.5.94
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <20040122045458.5B2922C100@lists.samba.org>
In-Reply-To: <20040122045458.5B2922C100@lists.samba.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Message-Id: <200401221430.52323.pawelg@dabrowa.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia czw 22 stycznia 2004 05:51, Rusty Russell napisa³/a:
> Ani,
>
> 	I assume this should be in 2.6's drivers/video/riva/fbdev.c as
> well?
>
> Rusty.
>
Well, I've just checked rivafb under 2.6.1 and I didn't notice this mistake - 
there are good colours in Midnight Commander. Probably this bug was repaired 
somewhere in 2.5.
But I have no idea which options should I send to kernel to get different 
resolution (video=riva:800x600-16@85 don't work) and I have very ugly Linux 
logo while booting ;)
-- 
	===>  Goldi  <===
Linux user since Jan 16 2000 (#176912)
Proletariusze wszystkich krajów ¶wiata
u¿ywajcie systemu Linux!
