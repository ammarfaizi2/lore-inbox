Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbUKDMOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbUKDMOv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbUKDMOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:14:50 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:18418 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S262179AbUKDMMq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:12:46 -0500
Date: Thu, 04 Nov 2004 14:12:40 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: is killing zombies possible w/o a reboot?
In-reply-to: <200411040657.10322.gene.heskett@verizon.net>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, Tom Felker <tfelker2@uiuc.edu>
Message-id: <200411041412.42493.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <200411030751.39578.gene.heskett@verizon.net>
 <200411040919.54226.jk-lkml@sci.fi>
 <200411040657.10322.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 13:57, Gene Heskett wrote:

> I'e had that turned on since forever Jan, but usually, when its hung 
> someplace, its well and truely hung, and hardware reset button time.

Are you saying that these zombies (or tasks stuck in state D) also make
sysrq-T hang, and not list all tasks?
