Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289975AbSAPPfo>; Wed, 16 Jan 2002 10:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289982AbSAPPfe>; Wed, 16 Jan 2002 10:35:34 -0500
Received: from cj326439-a.alex1.va.home.com ([65.1.135.172]:35830 "EHLO
	xabean.xabean.net") by vger.kernel.org with ESMTP
	id <S289975AbSAPPfX>; Wed, 16 Jan 2002 10:35:23 -0500
Message-Id: <200201161537.g0GFbOB26942@xabean.xabean.net>
From: Richard Harman <rharman@xabean.net>
Cc: Richard Harman <rharman@xabean.net>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx driver v6.2.4 "queue abort message" questions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26938.1011195443.1@xabean.xabean.net>
Date: Wed, 16 Jan 2002 10:37:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a box that will nolonger boot off it's scsi disk anymore, (but dual booting to windows works just fine...) did anyone ever get to the bottom of what caused the "attempting to queue an abort message" bug was?  I've tried booting my normal 2.4.16+preempt and a 2.4.2 kernel known to work previously and neither get pass trying to identify the devices on both channels.

Richard G Harman Jr <rharman+nospam@xabean.net>

