Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTKPKqG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 05:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTKPKqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 05:46:06 -0500
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:24989 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262694AbTKPKqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 05:46:03 -0500
Message-ID: <3FB75569.6040408@tudorejo.org>
Date: Sun, 16 Nov 2003 21:46:01 +1100
From: Tudor <tudor@tudorejo.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Matrox Acceleration Probably_Just_Cosmetic Bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Stewart Smith told me that this is where I report strange Linux Kernel bugs.

I'm running make menuconfig on 2.6.0-test9
I've come across a strange cosmetic bug under:
Device Drivers->Graphics Support

If you select "Matrox Acceleration" either built in or as module there 
are two options:
- G100/G200/G400/G450/G500 support
and
- G100/G200/G400 support

If you select the first, the second disappears.
If you select the second, the first stays.

I have a G400, so this is a bit confusing.

Hope this helps somebody.  :-)

Keep up the good work.

Cheers,
Tudor.

