Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWAYSXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWAYSXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWAYSXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:23:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49161 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932092AbWAYSXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:23:47 -0500
Date: Wed, 25 Jan 2006 19:25:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: grundig@teleline.es, Joerg Schilling <schilling@fokus.fraunhofer.de>,
       jengelh@linux01.gwdg.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060125182552.GB4212@suse.de>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D7C1DF.1070606@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25 2006, Matthias Andree wrote:
> Jens Axboe wrote:
> 
> > In fact it would be a _lot_ easier to just scan sysfs and do an inquiry
> > on potentially useful devices.
> 
> Hm. sysfs, procfs, udev, hotplug, netlink (for IPv6) - this all looks rather
> complicated and non-portable. I understand that applications that can just
> open every device and send SCSI INQUIRY might want to do that on Linux, too.

Certainly, I'm just suggesting a better way to do it on Linux.

-- 
Jens Axboe

