Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275933AbSIUSp1>; Sat, 21 Sep 2002 14:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275934AbSIUSp1>; Sat, 21 Sep 2002 14:45:27 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:60171 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S275933AbSIUSp1>; Sat, 21 Sep 2002 14:45:27 -0400
Date: Sat, 21 Sep 2002 20:50:13 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: problems building bzImage with 2.5.*
Message-ID: <20020921185013.GA1320@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20020921183527.GL22811@kruhft.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020921183527.GL22811@kruhft.dyndns.org>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Burton Samograd <kruhft@kruhft.dyndns.org>
Date: Sat, Sep 21, 2002 at 11:35:27AM -0700
> Hi all,
> 
> I'm quite new to the list and I'm not sure if this has been posted
> already but I thought I would give it a shot. I've been trying to
> build the 2.5.* kernels (2.5.37 at the moment but this has happened
> with previous version as well) and when doing a make bzImage i keep
> getting the following error during the final linkage:
> 
> drivers/built-in.o(.data+0xac34): undefined reference to `local
> symbols in discarded section .text.exit'
> make: *** [vmlinux] Error 1
> 
I think this means you need to update your binutils.

Kind regards,
Jurriaan
-- 
A man's silence is wonderful to listen to.
        THOMAS HARDY
GNU/Linux 2.5.37 SMP/ReiserFS 2x1380 bogomips load av: 0.05 0.03 0.05
