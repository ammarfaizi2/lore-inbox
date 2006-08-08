Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWHHEnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWHHEnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 00:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWHHEnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 00:43:08 -0400
Received: from bm-5a.paradise.net.nz ([203.96.152.184]:36485 "EHLO
	linda-5.paradise.net.nz") by vger.kernel.org with ESMTP
	id S932482AbWHHEnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 00:43:07 -0400
Date: Tue, 08 Aug 2006 16:38:50 +1200
From: Theuns Verwoerd <theuns@bluewatersys.com>
Subject: Re: [PATCH 001/001] I2C: AD7414 I2C chip driver for Linux-2.6.17.7
In-reply-to: <20060806133115.0b3bfe3f.khali@linux-fr.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Rudolf Marek <r.marek@sh.cvut.cz>,
       linux-kernel@vger.kernel.org
Message-id: <44D8155A.5060005@bluewatersys.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
References: <44D28C60.1000304@bluewatersys.com>
 <20060803202336.07c2b2a2.rdunlap@xenotime.net>
 <20060806133115.0b3bfe3f.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings

Jean Delvare wrote:
> Hi Theuns, Randy,
>
> [Theuns Verwoerd]
>   
>>> AD7414 Temperature Sensor I2C driver.  I2C chip driver for the Analog
>>> Devices AD7414 device, exposes raw and decoded registers via sysfs.
>>> Signed-off-by: Theuns Verwoerd <theuns.verwoerd@bluewatersys.com>
...
> 9* The driver should be submitted for review to the lm-sensors list
> (see MAINTAINERS) rather than the LKML.
>   
Thank you for your comments - merged in, resubmitted to lm-sensors 
mailing list.

Theuns
KRN
