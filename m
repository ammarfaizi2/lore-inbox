Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbUAFNiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 08:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUAFNiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 08:38:25 -0500
Received: from postbode02.zonnet.nl ([62.58.50.89]:10402 "EHLO
	postbode02.zonnet.nl") by vger.kernel.org with ESMTP
	id S262901AbUAFNiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 08:38:23 -0500
From: S Ait-Kassi <sait-kassi@zonnet.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [update]  Vesafb problem since 2.5.51
Date: Tue, 6 Jan 2004 14:40:55 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401061440.55724.sait-kassi@zonnet.nl>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.2; VDF: 6.23.0.22; host: postbode02.zonnet.nl)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 January 2004 23:13, you wrote:
> Please try my latest patch. I tested midnight commander on my system and
> my system is okay. This is using the vesa framebuffer.
>
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Just tried the patch with the 2.6.0 kernel and it didn't help. As a bonus 
"feature" the cursor also makes the character it is underlining blink.

I assume that something broke in 2.5.51 on some cards (maybe while making 
fb-con modular?). Three of the four people who stated they had this problem 
had a ATI card (two had a Radeon 7500 and I have a Radeon 9500 and one didn't 
include the videocard). :( 

I have no idea what change could be the cause.

If I could help you with more info please say so.

Thanks again,

S Ait-Kassi

