Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTLNUUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 15:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTLNUUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 15:20:51 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:55212 "EHLO
	ns.kalifornia.com") by vger.kernel.org with ESMTP id S262360AbTLNUUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 15:20:50 -0500
Message-ID: <3FDCC61C.80008@blue-labs.org>
Date: Sun, 14 Dec 2003 15:20:44 -0500
From: David Ford <david+hb@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: dc2xx.c ported yet?
References: <20031214201707.GA24409@triplehelix.org>
In-Reply-To: <20031214201707.GA24409@triplehelix.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't need to be.  It is accessed via libusb these days opening 
/proc/bus/usb/*/*

Emerge (apt-get, etc, as per your distro of choice) something like 
gphoto2 which should include libusb by dependancy and setup hotplug.  If 
you need help with hotplug, buzz me, I have a dc2xx camera I use very often.

David

Joshua Kwan wrote:

>Hi, I noticed that CONFIG_USB_DC2XX is not available in the 2.6 tree and
>dc2xx.c doesn't exist either. However, it's available in 2.4. Does the
>driver need to be ported? If so, can I help?
>
>  
>
