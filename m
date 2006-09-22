Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWIVVmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWIVVmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 17:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWIVVmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 17:42:54 -0400
Received: from server6.greatnet.de ([83.133.96.26]:16800 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932197AbWIVVmy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 17:42:54 -0400
Message-ID: <451458EA.8080502@nachtwindheim.de>
Date: Fri, 22 Sep 2006 23:43:06 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: trailing whitespaces in the Linux-kernel :)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I've played around with Andrew Morton's script to remove trailing white spaces in kernel patches.
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

I used it against the official patches from www.kernel.org and this is the result:

Kernelversion	Size of the patch	Size without trailing WS Number of trailing WS percent of patch

2.6.12		24539730		24531535		8195			0.0334%
2.6.13		28539730		28942472		1923			0.0066%
2.6.14		23024224		23021802		2422			0.0105%
2.6.15		34260720		34258304		2416			0.0071%
2.6.16		29085385		29082215		3170			0.0109%
2.6.17		32637502		32636357		1145			0.0035%
2.6.18		30005947		30005192		 755			0.0025%

2.6.17-rc7-mm1	26559614		26559450		 164			0.0006%

Happy hacking,
Henne




