Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTL2DV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 22:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTL2DV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 22:21:26 -0500
Received: from rocket.alienwebshop.com ([216.120.226.160]:35342 "EHLO
	rocket.alienwebshop.com") by vger.kernel.org with ESMTP
	id S262564AbTL2DVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 22:21:25 -0500
Date: Sun, 28 Dec 2003 22:21:25 -0500 (EST)
From: Peter Leftwich <Hostmaster@Video2Video.Com>
X-X-Sender: pete@rocket.alienwebshop.com
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: debian-bsd@lists.debian.org, debian-user@lists.debian.org,
       owner-linux-kernel@vger.kernel.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: mount from debian to 44bsd, chown bug report?
In-Reply-To: <1072655768.6994.125.camel@nosferatu.lan>
Message-ID: <20031228222016.H71260@rocket.alienwebshop.com>
References: <20031228183005.G86605@rocket.alienwebshop.com>
 <1072655768.6994.125.camel@nosferatu.lan>
Organization: Video2Video Services - http://Www.Video2Video.Com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, Martin Schlemmer wrote:
> Uhm, if /mnt/test is in a ro filesystem, mounting a partition to it
> rw will still not get you to change /mnt/test - sure, you will be
> able to chown /mnt/test/foo ....
> Martin Schlemmer

The first slash "/" of /mnt/test is the root directory and it is mounted rw
(not ro) in ram as a ramdisk.

--
Peter Leftwich
President & Founder, Video2Video Services
Box 13692, La Jolla, CA, 92039 USA
http://Www.Video2Video.Com
