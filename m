Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSGVL2T>; Mon, 22 Jul 2002 07:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSGVL2S>; Mon, 22 Jul 2002 07:28:18 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:29181 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316768AbSGVL2R>; Mon, 22 Jul 2002 07:28:17 -0400
Subject: Re: Athlon XP 1800+ segemntation fault
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Karol Olechowskii <karol_olechowski@acn.waw.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020722133259.A1226@acc69-67.acn.pl>
References: <20020722133259.A1226@acc69-67.acn.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 13:44:10 +0100
Message-Id: <1027341850.31782.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 14:32, Karol Olechowskii wrote:
> Hello 
> 
> Few days ago I've bought new processor Athlon XP 1800+ to my computer
> (MSI K7D Master with 256 MB PC2100 DDR).Before that I've got Athlon ThunderBird
> 900 processor and everything had been working well till I change to the new one.
> Now for every few minutes I've got segmetation fault or immediate system reboot.
> Could anyone tell me what's goin' on?

> nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002
> devfs_register(nvidiactl): could not append to parent, err: -17
> devfs_register(nvidia0): could not append to parent, err: -17

Please duplicate the problem without ever loading the NVidia nvdriver
from a clean boot. If you can't do that then talk to Nvidia, if you can
then post new crash data here

