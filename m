Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbUDFHNG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 03:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263648AbUDFHNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 03:13:06 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:12015 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S263642AbUDFHND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 03:13:03 -0400
Subject: Re: regression: oops with usb bcm203x bluetooth dongle 2.6.5
From: Soeren Sonnenburg <kernel@nn7.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1081207065.17215.6.camel@pegasus>
References: <1081196482.3591.5.camel@localhost>
	 <1081199370.2843.20.camel@pegasus>  <1081200442.3591.38.camel@localhost>
	 <1081201227.2843.27.camel@pegasus>  <1081201957.3590.49.camel@localhost>
	 <1081207065.17215.6.camel@pegasus>
Content-Type: text/plain
Message-Id: <1081235549.2050.3.camel@localhost>
Mime-Version: 1.0
Date: Tue, 06 Apr 2004 09:12:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 01:17, Marcel Holtmann wrote: 

Hello Marcel,

forget about the while [] change in the hotplug firmware script. It still oopses :(

I was even able to cause the very same oops when I used
/sbin/bluefw.inactive to load the firmware !

Regards,
Soerern

