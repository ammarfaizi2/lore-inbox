Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbUANXII (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUANXHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:07:06 -0500
Received: from mx1.it.wmich.edu ([141.218.1.89]:64995 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S265848AbUANXGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:06:52 -0500
Message-ID: <4005CB88.5000409@wmich.edu>
Date: Wed, 14 Jan 2004 18:06:48 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-mm3 lm_sensors outdated?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sensors: numerical sysctl 7 2 1 is obsolete.
sensors: numerical sysctl 7 2 1 is obsolete.

I now get these warnings when loading the i2c via686a and viapro modules 
  in my dmesg output. Apparently this stops the modules from creating 
sysfs entries that it used to be able to do in 2.6.0-mm1.  Is this just 
me or is this happening to everyone?

