Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292539AbSCOOTv>; Fri, 15 Mar 2002 09:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292554AbSCOOTl>; Fri, 15 Mar 2002 09:19:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39179 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292539AbSCOOTW>; Fri, 15 Mar 2002 09:19:22 -0500
Subject: Re: unwanted disk access by the kernel?
To: dmaas@dcine.com (Dan Maas)
Date: Fri, 15 Mar 2002 14:35:14 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020315013644.A26891@morpheus> from "Dan Maas" at Mar 15, 2002 01:36:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lsnb-0003mn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (I'm running a stock Linus 2.4.18 kernel, with APM enabled. The system
> is Debian woody. All filesystems are ext2.)

Mounted with or without noatime ?
