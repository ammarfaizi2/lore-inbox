Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbTICGSI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 02:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263501AbTICGSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 02:18:08 -0400
Received: from pimout6-ext.prodigy.net ([207.115.63.78]:19080 "EHLO
	pimout6-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262821AbTICGSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 02:18:03 -0400
Message-ID: <3F5587A1.2020706@ameritech.net>
Date: Wed, 03 Sep 2003 01:18:09 -0500
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: re: 2.6.0-test 4 and USB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to note on the USB and CUPs problem that I see the USB tree 
under "/sys/bus/usb" where-as under /proc/bus/usb I see nothing.
This may break a lot of existing code... Is is suppose to be this way?



