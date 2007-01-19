Return-Path: <linux-kernel-owner+w=401wt.eu-S932333AbXASPki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbXASPki (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 10:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbXASPki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 10:40:38 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:4451 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932333AbXASPkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 10:40:37 -0500
Message-ID: <45B0E672.4080404@xs4all.nl>
Date: Fri, 19 Jan 2007 16:40:34 +0100
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB extension (repeater) cable
X-Enigmail-Version: 0.94.2.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just tried my shiny new usb extension cable (repeater):

Jan 19 16:01:17 epia kernel: usb 5-1: new high speed USB device using
ehci_hcd and address 60
Jan 19 16:01:17 epia kernel: usb 5-1: configuration #1 chosen from 1 choice
Jan 19 16:01:17 epia kernel: hub 5-1:1.0: USB hub found
Jan 19 16:01:17 epia kernel: hub 5-1:1.0: 4 ports detected
Jan 19 16:01:18 epia kernel: hub 5-1:1.0: Cannot enable port 1.  Maybe
the USB cable is bad?
Jan 19 16:01:22 epia last message repeated 3 times
Jan 19 16:01:23 epia kernel: hub 5-1:1.0: Cannot enable port 2.  Maybe
the USB cable is bad?
Jan 19 16:01:26 epia last message repeated 3 times
Jan 19 16:01:27 epia kernel: hub 5-1:1.0: Cannot enable port 3.  Maybe
the USB cable is bad?
Jan 19 16:01:31 epia last message repeated 3 times

The second cable does the same.
Of course we have just one port on this hub...
Any ideas?
