Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264902AbSKEQov>; Tue, 5 Nov 2002 11:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbSKEQov>; Tue, 5 Nov 2002 11:44:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4755 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264902AbSKEQoD>;
	Tue, 5 Nov 2002 11:44:03 -0500
Date: Tue, 5 Nov 2002 17:50:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105165024.GJ13587@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can it really be that one cannot edit a config file and run make
oldconfig anymore? I'm used to editing an entry in .config and running
oldconfig to fix things up, now it just reenables the option. That's
clearly a major regression.

-- 
Jens Axboe

