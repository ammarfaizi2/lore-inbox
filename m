Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264306AbTIITLW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTIITLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:11:21 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:60940
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264306AbTIITLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:11:16 -0400
Date: Tue, 9 Sep 2003 12:11:36 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Chris Bell <chriseebee@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KDE System Monitor not reporting correct Memory/Swap Usage
Message-ID: <20030909191136.GC28279@matchmail.com>
Mail-Followup-To: Chris Bell <chriseebee@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <Law10-F11358EMJmAkx00000dbb@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law10-F11358EMJmAkx00000dbb@hotmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 08:40:34AM +0100, Chris Bell wrote:
> Kernel: 2.6.0-test4-bk5
> KDE: 3.1.3
> 
> Hi
> 
> I have just installed the above kernel successfully and generally all good. 
> However, the KDE System Monitor is not displaying the correct memory or 
> swap usage.
> 
> I have 1gig of RAM and over 1gig of Swap space and "top" is correctly 
> showing this. However, the monitor is showing 10k of RAM and Swap. This was 
> fine in 2.4.20-8.

do you have sysfs mounted on /sys?  It works fine for me once I do this.
