Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTIMAvZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 20:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbTIMAvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 20:51:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44969 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261969AbTIMAvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 20:51:24 -0400
Date: Sat, 13 Sep 2003 01:51:23 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alberto Bertogli <albertogli@telpin.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file_lock_cache won't shink down
Message-ID: <20030913005123.GE21596@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Alberto.  Please try
http://ftp.linux.org.uk/pub/linux/willy/patches/flock-memleak.diff

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
