Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTDVTrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTDVTrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:47:55 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12679 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263464AbTDVTry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:47:54 -0400
Date: Tue, 22 Apr 2003 16:02:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Balram Adlakha <b_adlakha@softhome.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] fbcon
In-Reply-To: <200304240105.21711.b_adlakha@softhome.net>
Message-ID: <Pine.LNX.4.53.0304221600370.14949@chaos>
References: <200304240105.21711.b_adlakha@softhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003, Balram Adlakha wrote:

> There seems to be a problem in the frame buffer console, It appears as if the
> resolution has been changed from 1024x768 to 1024x800 or something like that
> (I can only half see the sh prompt when it has come down), but the argument I
> passed at boot time was still 788. It doesn't appear to have been solved
> according to the bk csets taken from kernel.org.
>

Did you reset your monitor so it remembers the height/width/centering for
your new resolution? Maybe you didn't know?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

