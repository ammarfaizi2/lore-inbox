Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSHVRoe>; Thu, 22 Aug 2002 13:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSHVRoe>; Thu, 22 Aug 2002 13:44:34 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51443 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314634AbSHVRod>; Thu, 22 Aug 2002 13:44:33 -0400
Subject: Re: PROBEM: kernel crashes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bernard Paris <Bernard.Paris@psp.ucl.ac.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p0510030eb98a4c160c61@[130.104.82.36]>
References: <p0510030eb98a4c160c61@[130.104.82.36]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 22 Aug 2002 18:49:50 +0100
Message-Id: <1030038590.3161.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 09:56, Bernard Paris wrote:
> 
> [1.] kernel crashes, most often while dumping to scsi tape.
> 
> [2.]
> I've had several linux crashes with 3 different server machines running
> RedHat 7.x, where I had compiled successive versions of the kernel.

Thats classic memory or heat stuff in general. Do the boxes pass
memtest86 firstly ?

