Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310425AbSCPQ3n>; Sat, 16 Mar 2002 11:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310428AbSCPQ3d>; Sat, 16 Mar 2002 11:29:33 -0500
Received: from [212.18.235.99] ([212.18.235.99]:58116 "EHLO street-vision.com")
	by vger.kernel.org with ESMTP id <S310425AbSCPQ3S>;
	Sat, 16 Mar 2002 11:29:18 -0500
From: Justin Cormack <kernel@street-vision.com>
Message-Id: <200203161629.g2GGTHo02311@street-vision.com>
Subject: quick sd question
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Mar 2002 16:29:16 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, a quick question, as I seem to be blind today...

sd.c helpfully says:

/*
 * requeue_sd_request() is the request handler function for the sd driver.
 * Its function in life is to take block device requests, and translate
 * them to SCSI commands.
 */

This could usefully be deleted, as this function doesnt exist.

However I cannot find the code that actually does this - any pointers?

thanks

Justin

