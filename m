Return-Path: <linux-kernel-owner+w=401wt.eu-S1030354AbXAEGl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbXAEGl5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 01:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbXAEGl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 01:41:57 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:48261 "EHLO
	pd5mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030354AbXAEGl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 01:41:56 -0500
Date: Fri, 05 Jan 2007 00:17:57 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: JMicron JMB363 problems
In-reply-to: <fa.BLvaVGUEaalCt5SgPUsZ22hFA44@ifi.uio.no>
To: xt knight <xtknight.l@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <459DED95.7080509@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.BLvaVGUEaalCt5SgPUsZ22hFA44@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xt knight wrote:
> I've been receiving odd error messages (accompanied by freezing up)
> over the days.  They are originating from the JMicron controller.
> 
> Setup:
> Gigabyte GA-965P-DS3 (Intel 965P Express) rev 2.0, latest BIOS (F9)
> -Intel ICH8 on-board [IDE emulation mode]
> --250G Maxtor SATA --   /dev/sda
> --250G Western Digital SATA  --   /dev/sdb
> 
> -JMicron JBM363 on-board [IDE mode]
> --Toshiba-Samsung DVD burner IDE (primary) --  /dev/hde
> --HP DVD burner IDE (slave) --  /dev/hdf

Have you tried running this controller with the libata driver in AHCI mode?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

