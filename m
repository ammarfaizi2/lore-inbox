Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266691AbRGLVcq>; Thu, 12 Jul 2001 17:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266608AbRGLVcg>; Thu, 12 Jul 2001 17:32:36 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:53259 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S266691AbRGLVc1>; Thu, 12 Jul 2001 17:32:27 -0400
Message-Id: <200107122132.f6CLWRU61362@aslan.scsiguy.com>
To: Luc Lalonde <llalonde@giref.ulaval.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec SCSI driver lockups 
In-Reply-To: Your message of "Thu, 12 Jul 2001 17:21:40 EDT."
             <3B4E14E4.BF0497@giref.ulaval.ca> 
Date: Thu, 12 Jul 2001 15:32:27 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello folks,
>
>I'm having trouble identifying wether I'm having hardware or software(
>OS ) problems.  For the past couple of Months I've been having system
>lockups every 10 days or so.

Are there any kernel messages printed prior to the lockup?
Please attach a serial cable to another machine, enable serial console
support, run with aic7xxx=verbose, and log all console activity remotely.

--
Justin
