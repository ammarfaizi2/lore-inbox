Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbUA3MMW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 07:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUA3MMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 07:12:22 -0500
Received: from mail1.portalis.it ([213.199.4.23]:52753 "EHLO portalis.it")
	by vger.kernel.org with ESMTP id S263592AbUA3MMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 07:12:21 -0500
Message-ID: <401A4921.6090908@tiscali.it>
Date: Fri, 30 Jan 2004 13:08:01 +0100
From: Carlo Salinari <csali@tiscali.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: possible hint for "irq 11: nobody cared!" (asus p4p800)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've had a hard time at work trying to install 2.6.1 on a ASUS P4P800 
motherboard
(whith RAID controller _disabled_ in the bios).

I constantly got "irq 11: nobody cared!" message, which I now see is a 
known problem
here.

After many (many!) tries whith different compilation/boot-time options, 
whith
both 2.6.1 and 2.4.24, I just realized that Debian Woody's (3.0r1) bf24 
kernel
(2.4.18) boots flawlessly.

I thought that possibly this might be a hint for the experts on the list.

cheers,
    Carlo Salinari
