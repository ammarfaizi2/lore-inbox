Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUBQNY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 08:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266171AbUBQNY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 08:24:27 -0500
Received: from ns.schottelius.org ([213.146.113.242]:62110 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S266169AbUBQNYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 08:24:25 -0500
Date: Tue, 17 Feb 2004 14:24:30 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb issue in 2.6 or notebook defect?
Message-ID: <20040217132430.GZ1881@schottelius.org>
References: <20040217110840.GR1881@schottelius.org> <20040217110928.GS1881@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217110928.GS1881@schottelius.org>
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still on it...

I asked some other people who all could confirmed that after copying
much data (>=1-2GB) to/from a usb disk, the copy/tar/ whatever will
freeze and then you'll have to reconnect the device to use it again
(in my case with devfs the old entries still exist and the second time
it become sdb)

Is it really still a problem to use mass storage under Linux?

Greetings,

Nico
