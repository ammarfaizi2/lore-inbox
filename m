Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbUCBTKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 14:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUCBTKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 14:10:11 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10624 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261743AbUCBTKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 14:10:08 -0500
Date: Tue, 2 Mar 2004 14:10:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Albert Hafvenstrom <albhaf@home.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Better performance with 2.6
In-Reply-To: <20040302195155.0384abdc.albhaf@home.se>
Message-ID: <Pine.LNX.4.53.0403021406560.1166@chaos>
References: <1078229894.53b994c0albhaf@home.se> <20040302195155.0384abdc.albhaf@home.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Albert Hafvenstrom wrote:

> One of the things I found was that 2.6 detected my full CPU-capacity
> (nad even a bit more).
> Before, with 2.4, it showed my AMD Duron as 799.xxxx but now it is 800.047
> Is it because of some specific reason or does it just happen?
>
> /albhaf

Are you talking about BogoMips??  This is just how many twinkies
you can eat in a second with the current coding style in the
short timer counter. It has absolutely, positively, nothing to
do with "CPU capacity".

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


