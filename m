Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268539AbTCAKTl>; Sat, 1 Mar 2003 05:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268543AbTCAKTl>; Sat, 1 Mar 2003 05:19:41 -0500
Received: from mail.mediaways.net ([193.189.224.113]:41317 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S268539AbTCAKTl>; Sat, 1 Mar 2003 05:19:41 -0500
Subject: re: Linux 2.4.21pre4-ac5 status report
From: Soeren Sonnenburg <kernel@nn7.de>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030301085704.GA22135@louise.pinerecords.com>
References: <1046506460.1215.993.camel@sun>
	 <20030301085704.GA22135@louise.pinerecords.com>
Content-Type: text/plain
Organization: 
Message-Id: <1046514580.15694.2.camel@sun>
Mime-Version: 1.0
Date: 01 Mar 2003 11:29:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-01 at 09:57, Tomas Szepe wrote:
> > [kernel@nn7.de]
> > 
> > The promise driver still freezes on my pdc20268 when using >mdma0.
> 
> Try upgrading the BIOS on the 20268.  Sounds incredible, but it
> did solve all the problems I was seeing with the card in Linux.

I checked for new bioses 2 on thursday -> there where no newer bioses
available. I guess you have a single pdc20268 which is full of disks
(i.e. master and slave used?).

Soeren.

