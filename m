Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbTFCKI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 06:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264885AbTFCKI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 06:08:59 -0400
Received: from imsantv20.netvigator.com ([210.87.250.76]:34998 "EHLO
	imsantv20.netvigator.com") by vger.kernel.org with ESMTP
	id S264884AbTFCKI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 06:08:58 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: Counter-kludge for 2.5.x hanging when writing to block device
Date: Tue, 3 Jun 2003 18:21:47 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Jens Axboe <axboe@suse.de>
References: <200306030848.h538mwE22282@freya.yggdrasil.com> <20030603091018.GI482@suse.de> <20030603030023.69d39d6e.akpm@digeo.com>
In-Reply-To: <20030603030023.69d39d6e.akpm@digeo.com>
X-OS: GNU/Linux 2.5.70
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306031821.47880.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 June 2003 18:00, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> > On Tue, Jun 03 2003, Adam J. Richter wrote:
> > > 	For at least the past few months, the Linux 2.5 kernels have
> > > hung when I try to write a large amount of data to a block device.
>
> Well ytf is this the first time I've heard about it?
>

Lots of people are using 2.5 in many configurations. This kind of
would have shown long ago.

Suspect driver/hardware specific issue.

More info on hardware is needed.

Regards
Michael

