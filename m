Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284507AbRLHT6x>; Sat, 8 Dec 2001 14:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284568AbRLHT6n>; Sat, 8 Dec 2001 14:58:43 -0500
Received: from yuha.menta.net ([212.78.128.42]:32143 "EHLO yuha.menta.net")
	by vger.kernel.org with ESMTP id <S284563AbRLHT6Z>;
	Sat, 8 Dec 2001 14:58:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ivanovich <ivanovich@menta.net>
To: war <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: Impact of HIGHMEM?
Date: Sat, 8 Dec 2001 20:57:54 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <3C1263FE.EBD973FA@starband.net>
In-Reply-To: <3C1263FE.EBD973FA@starband.net>
MIME-Version: 1.0
Message-Id: <01120820485101.01267@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A Dissabte 08 Desembre 2001 20:03, war va escriure:
> Does anyone have any benchmarks as to how much HIGHMEM affects
> performance in Linux?
>
> Searched google.com + groups.google.com, couldn't find anything solid
> though.

why don't you try to compile a kernel with HIGHMEM and another without it and 
then run some benchmarks in each one and compare?

not everyone have the amount of ram to test this (i only have 
256...(sigh)) if i had that amount i would run some bench...

