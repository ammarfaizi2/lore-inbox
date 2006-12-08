Return-Path: <linux-kernel-owner+w=401wt.eu-S1425586AbWLHQT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425586AbWLHQT3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760753AbWLHQT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:19:29 -0500
Received: from mtai03.charter.net ([209.225.8.183]:40382 "EHLO
	mtai03.charter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760745AbWLHQT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:19:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17785.36959.226941.657811@smtp.charter.net>
Date: Fri, 8 Dec 2006 11:18:39 -0500
From: "John Stoffel" <john@stoffel.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Matthias Schniedermeyer <ms@citd.de>, Pete Zaitcev <zaitcev@redhat.com>,
       usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
In-Reply-To: <457958C9.6010901@s5r6.in-berlin.de>
References: <Pine.LNX.4.44L0.0612071306180.3537-100000@iolanthe.rowland.org>
	<45786E58.5070308@citd.de>
	<20061207154545.6eb516c4.zaitcev@redhat.com>
	<45792D74.5000901@citd.de>
	<457958C9.6010901@s5r6.in-berlin.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-Chzlrs: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Stefan" == Stefan Richter <stefanr@s5r6.in-berlin.de> writes:

Stefan> Search for firmware updates from the manufacturer of the
Stefan> enclosure, of the bridge board, or of the bridge chip... if
Stefan> you didn't do so already.  Some chips support firmware upload
Stefan> to an EEPROM, usually via a Windows utility.

I did this with my USB2.0/Firewire external enclosure and it fixed
most of the problems, but enough remained that I've basically given up
on those enclosures, they're just not reliable in my book.  

John
