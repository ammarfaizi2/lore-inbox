Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264470AbTLTN7C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 08:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTLTN7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 08:59:02 -0500
Received: from corvette.lateapex.net ([64.236.104.2]:63166 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264470AbTLTN7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 08:59:01 -0500
From: Jason Van Patten <jvp@lateapex.net>
Message-Id: <200312201358.hBKDwu9E009989@localhost.localdomain>
Subject: Re: Adaptec DPT_I2O Driver
To: linux-kernel@vger.kernel.org (linux)
Date: Sat, 20 Dec 2003 08:58:56 -0500 (EST)
Reply-To: jvp@lateapex.net
In-Reply-To: <no.id> from "jvp" at Dec 18, 2003 08:27:32 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At Thu Dec 18 08:27:32 2003, jvp wrote:
> In the 2.6 tree, the driver drivers/scsi/dpt_i2o.c has a #error in it that
> prevents it from being compiled.  The note in the file is:
> 
> #error Please convert me to Documentation/DMA-mapping.txt

Can I assume that because no one's replied to my question regarding this
broken driver, that no one's currently working on it?

jas
-- 
Jason Van Patten
AOL IM: Jason VP 

