Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbWARX1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWARX1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWARX1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:27:52 -0500
Received: from [200.91.100.172] ([200.91.100.172]:16970 "EHLO
	IPOfCard1.guest-tek.com") by vger.kernel.org with ESMTP
	id S1030447AbWARX1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:27:51 -0500
Message-ID: <43CECEFD.5010200@linuxwireless.org>
Date: Wed, 18 Jan 2006 17:27:57 -0600
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: version.h?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    Shouldn't there be a version.h on include/linux?

I use the Linus git tree and it's basically broken right now...

debian:~/linux-2.6# joe include/linux/v         
vermagic.h       video_decoder.h  video_encoder.h  vt_buffer.h
vfs.h            videodev2.h      videotext.h      vt.h
via.h            videodev.h       vmalloc.h        vt_kern.h

.Alejandro
