Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSFUJZP>; Fri, 21 Jun 2002 05:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSFUJZP>; Fri, 21 Jun 2002 05:25:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9948 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316512AbSFUJZO>;
	Fri, 21 Jun 2002 05:25:14 -0400
Date: Fri, 21 Jun 2002 11:24:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: hda: error: DMA in progress..
Message-ID: <20020621092459.GD27090@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

I gave 2.5.24 a spin, and it quickly dies with the error in subject,
under moderate disk load. It's an IBM travel star on a PIIX4.

-- 
Jens Axboe

