Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314143AbSDQWEM>; Wed, 17 Apr 2002 18:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314144AbSDQWEL>; Wed, 17 Apr 2002 18:04:11 -0400
Received: from scl-ims.phoenix.com ([134.122.1.73]:64528 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP
	id <S314143AbSDQWEL>; Wed, 17 Apr 2002 18:04:11 -0400
Message-ID: <7FD8B823E5024E44B027221DEB34C087536510@scl-exch.phoenix.com>
From: Paul Zimmerman <Paul_Zimmerman@inSilicon.com>
To: "'linux-usb-devel@lists.sourceforge.net'" 
	<linux-usb-devel@lists.sourceforge.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8
Date: Wed, 17 Apr 2002 14:09:32 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We already have drivers/usb/hcd for "host controller drivers", how about
drivers/usb/dcd for "device controller drivers"?

-Paul
