Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317002AbSFKLL1>; Tue, 11 Jun 2002 07:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317003AbSFKLL0>; Tue, 11 Jun 2002 07:11:26 -0400
Received: from pD952A4ED.dip.t-dialin.net ([217.82.164.237]:13776 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317002AbSFKLLZ>; Tue, 11 Jun 2002 07:11:25 -0400
Date: Tue, 11 Jun 2002 05:11:13 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Russell King <rmk@arm.linux.org.uk>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
In-Reply-To: <20020611083947.A1346@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0206110510510.24261-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Jun 2002, Russell King wrote:
> Is it really worth adding complexity to a build system to work around
> what is really a GCC bug for just one file?  I don't think so.

Think big! Think about __future__.

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

