Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSGMOVN>; Sat, 13 Jul 2002 10:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSGMOVM>; Sat, 13 Jul 2002 10:21:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:18927 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313898AbSGMOVI>; Sat, 13 Jul 2002 10:21:08 -0400
Subject: Re: IDE/ATAPI in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jbradford@dial.pipex.com
Cc: linux-kernel@vger.kernel.org, thunder@ngforever.de, schilling@fokus.gmd.de
In-Reply-To: <200207131407.PAA00242@darkstar.example.net>
References: <200207131407.PAA00242@darkstar.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 16:32:49 +0100
Message-Id: <1026574369.13886.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 15:07, jbradford@dial.pipex.com wrote:

> Both of the existing drivers would become the legacy driver, and a new one would be forked from the legacy code, which abstracts the physical interface altogether.  Eventually, we're going to have IDE, ATAPI (I.E. mostly non-disk IDE devices), SCSI, SASI(maybe :-)), USB, FireWire, Bluetooth, etc.  The number of interfaces is just going to grow and grow.

I look forward to seeing your patches

