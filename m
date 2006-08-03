Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWHCJUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWHCJUs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 05:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWHCJUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 05:20:48 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:62989 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932409AbWHCJUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 05:20:46 -0400
Date: Thu, 3 Aug 2006 11:20:54 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Greg KH <greg@kroah.com>, lm-sensors@lm-sensors.org,
       Shem Multinymous <multinymous@gmail.com>,
       "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-Id: <20060803112054.54d2b591.khali@linux-fr.org>
In-Reply-To: <20060802195107.GB8124@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	<20060727221632.GE3797@elf.ucw.cz>
	<41840b750607271556n1901af3by2e4d046d68abcb94@mail.gmail.com>
	<20060727230801.GA30619@kroah.com>
	<20060727232426.GI3797@elf.ucw.cz>
	<20060730142943.2537124e.khali@linux-fr.org>
	<20060802195107.GB8124@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > I guess we never felt any need for an "infrastructure", else we would
> > have created it. I have no idea what the "input infrastructure" looks
> > like so I can't compare. If you have something to propose which would
> > refactor some code amongst the hardware monitoring drivers or would
> > otherwise makes thing better, speak up :)
> 
> I'm not sure if it is practical for hwmon, but having
> report_voltage(x,y) is probably easier than coding sysfs stuff by
> hand.

I can't figure out what it would look like in practice. Do you have
some code to show?

Thanks,
-- 
Jean Delvare
