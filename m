Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129665AbRBULxC>; Wed, 21 Feb 2001 06:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130234AbRBULwn>; Wed, 21 Feb 2001 06:52:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3338 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130084AbRBULwh>; Wed, 21 Feb 2001 06:52:37 -0500
Subject: Re: QUOTA broken?
To: vibol@khmer.cc (Vibol Hou)
Date: Wed, 21 Feb 2001 11:55:57 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKIEGMEFAA.vibol@khmer.cc> from "Vibol Hou" at Feb 20, 2001 06:07:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VXsF-0001vf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can someone confirm that the 2.4.1-ac15+ quota system is NOT broken?  I am
> having problems running quota-2.00 on 2.4.1-ac15 although quota worked fine
> in 2.4.0.

You need the newer quota utilities. -ac fixes the quota support to handle
32bit uids

