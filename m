Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWFTOip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWFTOip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWFTOip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:38:45 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:5865 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751120AbWFTOio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:38:44 -0400
Date: Tue, 20 Jun 2006 16:38:37 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Paolo Ornati <ornati@fastwebnet.it>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: elevator.h problem
In-Reply-To: <20060620153012.2b50351d@localhost>
Message-ID: <Pine.LNX.4.61.0606201638090.25358@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0606201126001.2481@yvahk01.tjqt.qr>
 <20060620153012.2b50351d@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>So if you need "linux/elevator.h" you can just do:
>
>#include <linux/blkdev.h>

Ok that one worked, thanks.



Jan Engelhardt
-- 
