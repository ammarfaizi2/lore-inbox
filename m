Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbULVA4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbULVA4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbULVA4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:56:18 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:1701 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261931AbULVA4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:56:13 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Lee Revell <rlrevell@joe-job.com>
To: Pieter Palmers <pieterp@joow.be>
Cc: girish wadhwani <girish.wadh@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Arne Caspari <arnem@informatik.uni-bremen.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <41C8B330.8050803@joow.be>
References: <20041220015320.GO21288@stusta.de>
	 <41C694E0.8010609@informatik.uni-bremen.de>
	 <20041220175156.GW21288@stusta.de>
	 <1103576759.1252.93.camel@krustophenia.net>
	 <e2e1047f04122013493f5b0151@mail.gmail.com>  <41C8B330.8050803@joow.be>
Content-Type: text/plain
Date: Tue, 21 Dec 2004 19:56:12 -0500
Message-Id: <1103676972.2134.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-22 at 00:35 +0100, Pieter Palmers wrote:
> And isn't driver writing a bit of kernel hacking anyway? As far as I 
> know, you have to be very aware of kernel issues/internals when writing 
> a driver...

Ideally, not at all.  For example ALSA provides a very clean API for
driver writers.  If you know your hardware you could implement a driver
in a few days.

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/

Lee










