Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbTLWLEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 06:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbTLWLEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 06:04:51 -0500
Received: from quechua.inka.de ([193.197.184.2]:50347 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265101AbTLWLEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 06:04:50 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: [PATCH] some sysfs patches for 2.6.0 [0/4]
Date: Tue, 23 Dec 2003 12:07:43 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.12.23.11.07.41.714913@dungeon.inka.de>
References: <20031223002126.GA4805@kroah.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003 00:42:03 +0000, Greg KH wrote:

> Here are 4 sysfs related patches for 2.6.0. 

Thanks, thoses added many missing devices.

Are there usable patches to add these? url?
 - floppy devices (propably not necessary)
 - alsa sound devices (snd/ and sound/ (oss emulation))
 - input devices
 - printer devices

For my machine I compared udev and devfs and those are
the only devices not present in sysfs. I searched linux-kernel
archives for patches to add those, but couldn't find anything.

Regards,Andreas

