Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318747AbSH1Hcw>; Wed, 28 Aug 2002 03:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318748AbSH1Hcw>; Wed, 28 Aug 2002 03:32:52 -0400
Received: from ns0.tateyama.or.jp ([210.128.170.1]:41996 "HELO
	ns0.tateyama.or.jp") by vger.kernel.org with SMTP
	id <S318747AbSH1Hcv> convert rfc822-to-8bit; Wed, 28 Aug 2002 03:32:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gabor Kerenyi <wom@tateyama.hu>
To: Helge Hafting <helgehaf@aitel.hist.no>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.32 - some menuconfig oddities
Date: Wed, 28 Aug 2002 16:43:31 +0900
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com> <3D6C7C5D.4370C600@aitel.hist.no>
In-Reply-To: <3D6C7C5D.4370C600@aitel.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208281643.31560.wom@tateyama.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 August 2002 16:31, Helge Hafting wrote:
> This item is listed twice inthe IDE menu:
> RZ1000 chipset bugfix/support
>
> These are inaccessible
> Fusion MPT device support  --->
> Security options  --->

As I see for the latter one there is only one default
module in security/ and it is always compiled.

Gabor

