Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbVCEL6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbVCEL6a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 06:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbVCEL6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 06:58:30 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:47881 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263067AbVCEL6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 06:58:16 -0500
Date: Sat, 5 Mar 2005 12:59:02 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [BK PATCH] I2C patches for 2.6.11
Message-Id: <20050305125902.71286764.khali@linux-fr.org>
In-Reply-To: <20050304203531.GA31644@kroah.com>
References: <20050304203531.GA31644@kroah.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Here is a I2C update for 2.6.11.  It includes a number of fixes, and
> some new i2c drivers.  All of these patches have been in the past few
> -mm releases.

I checked against my own list of patches and found that I have two more,
which were posted to the sensors and kernel-janitors list in early
february:
http://archives.andrew.net.au/lm-sensors/msg29340.html
http://archives.andrew.net.au/lm-sensors/msg29342.html

They never made it to your own i2c tree, nor Andrew's tree. What do we
want to do with these?

Thanks,
-- 
Jean Delvare
