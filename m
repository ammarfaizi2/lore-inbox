Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318799AbSICP5R>; Tue, 3 Sep 2002 11:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSICP4P>; Tue, 3 Sep 2002 11:56:15 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:32494
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317312AbSICPzT>; Tue, 3 Sep 2002 11:55:19 -0400
Subject: Re: 2.4.20-pre4-ac1 trashed my system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Isely <isely@pobox.com>
Cc: mbs <mbs@mc.com>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0209030917040.17540-100000@grace.speakeasy.net>
References: <Pine.LNX.4.44.0209030917040.17540-100000@grace.speakeasy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 03 Sep 2002 17:00:58 +0100
Message-Id: <1031068858.21409.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately you've said you are using a 40GB drive and something other
> than a Promise controller so your situation may be a different problem.

The 40Gb drives may well be trying to pick LBA48, but LBA48 works on the
Intel hardware

