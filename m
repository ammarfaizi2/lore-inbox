Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425482AbWLHMVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425482AbWLHMVb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425486AbWLHMVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:21:31 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:48890 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425482AbWLHMVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:21:30 -0500
Message-ID: <457958C9.6010901@s5r6.in-berlin.de>
Date: Fri, 08 Dec 2006 13:21:29 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: Pete Zaitcev <zaitcev@redhat.com>, usb-storage@lists.one-eyed-alien.net,
       linux-kernel@vger.kernel.org
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
References: <Pine.LNX.4.44L0.0612071306180.3537-100000@iolanthe.rowland.org>	<45786E58.5070308@citd.de> <20061207154545.6eb516c4.zaitcev@redhat.com> <45792D74.5000901@citd.de>
In-Reply-To: <45792D74.5000901@citd.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> Pete Zaitcev wrote:
...
>>>>>I'm using a Bunch auf HDDs in USB-Enclosures for storing files.
>>>>>(currently 38 HDD, with a total capacity of 9,5 TB of which 8,5 TB is used)
...
>> You should buy a variety of different enclosures
>> with different chipsets (e.g. find a Freecom if you can),
> 
> That would definetly cost way to much money and time to be in any way
> "efficient".

Search for firmware updates from the manufacturer of the enclosure, of
the bridge board, or of the bridge chip... if you didn't do so already.
Some chips support firmware upload to an EEPROM, usually via a Windows
utility.
-- 
Stefan Richter
-=====-=-==- ==-- -=---
http://arcgraph.de/sr/
