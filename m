Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263063AbTCSQu4>; Wed, 19 Mar 2003 11:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263084AbTCSQu4>; Wed, 19 Mar 2003 11:50:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:27271 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263083AbTCSQux>; Wed, 19 Mar 2003 11:50:53 -0500
Date: Wed, 19 Mar 2003 12:03:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ed Vance <EdV@macrolink.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33DEE@EXCHANGE>
Message-ID: <Pine.LNX.4.53.0303191202450.31905@chaos>
References: <11E89240C407D311958800A0C9ACF7D1A33DEE@EXCHANGE>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, Ed Vance wrote:
[SNIPPED...]

> >
> Hi Richard,
>
> The following patch to serial.c in 2.4.20 is a brute-force addition
> of a hang-up delay of 0.5 sec just before close returns to the user,
> if the hupcl flag is set. Please try this to determine if there are
> any other issues with the remote login. If it works, I'll write a
> better patch that does not duplicate other delays, etc.
>
> Cheers,
> Ed

Okay. I will test this after about 4:00 PM when I can shut down
that machine. Thanks.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

