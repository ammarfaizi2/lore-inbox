Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274539AbRITPk6>; Thu, 20 Sep 2001 11:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274540AbRITPki>; Thu, 20 Sep 2001 11:40:38 -0400
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:42757 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S274539AbRITPkc> convert rfc822-to-8bit; Thu, 20 Sep 2001 11:40:32 -0400
X-Envelope-From: mmokrejs
Posted-Date: Thu, 20 Sep 2001 17:40:56 +0200 (MET DST)
Date: Thu, 20 Sep 2001 17:40:56 +0200 (MET DST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Perf improvements in 2.4.10pre12aa1
In-Reply-To: <Pine.OSF.4.21.0109201458230.24552-100000@prfdec.natur.cuni.cz>
Message-ID: <Pine.OSF.4.21.0109201737480.24552-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Martin MOKREJ© wrote:

There was an answer already posted, amazing!

> And, well oh NO!, it's here again:
> __alloc_pages: 0-order allocation failed (gfp=0x20/0) from c012f852

ksysmap: searching '/boot/System.map-2.4.10-pre12aa1' for 'c012f852'

c012f83c T _alloc_pages
c012f852 ..... <<<<<
c012f854 t balance_classzone



-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany

