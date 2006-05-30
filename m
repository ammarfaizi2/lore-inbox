Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWE3DsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWE3DsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 23:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWE3DsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 23:48:09 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:172 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751269AbWE3DsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 23:48:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Zbigniew Luszpinski <zbiggy@o2.pl>
Subject: Re: [Patch] Logitech TrackMan trackball - unknown device
Date: Mon, 29 May 2006 23:48:03 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200605281646.05765.zbiggy@o2.pl>
In-Reply-To: <200605281646.05765.zbiggy@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605292348.04002.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 May 2006 10:46, Zbigniew Luszpinski wrote:
> Hello!
> 
> When I connect to my linux 2.6.16.18 box a Logitech TrackMan trackball the 
> kernel welcomes me with message:
> 
> logips2pp: Detected unknown logitech mouse model 79
> input: ImExPS/2 Logitech Explorer Mouse as /class/input/input1
> 
> My patch makes TrackMan known for kernel 2.6.16.18. Other recent kernels 
> should work with this patch too. After applying patch kenel 2.6.16.18 says:
> 
> input: PS2++ Logitech TrackMan Whell as /class/input/input1
>

Applied, thank you,

-- 
Dmitry
