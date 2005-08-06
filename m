Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVHFJux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVHFJux (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 05:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVHFJuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 05:50:52 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:30864 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261959AbVHFJtj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 05:49:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jCskpUdsTsLByYdDFQz9Rwl1NYcQ2y2edY/SrDYLd8U/vFHSV+y1zkPPTUXtpOcHGhnliVWTFphckgopirKmzseNyW4w8Nicp59AaaLQh52uoApyDW+XnfDCmtieDLQjKxiv7/NjaQEPJD0to9Kcpy+aqkqTTf3Chz+K9Wn6eTc=
Message-ID: <de63970c05080602496c2c8b11@mail.gmail.com>
Date: Sat, 6 Aug 2005 10:49:33 +0100
From: Simon Morgan <sjmorgan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Outdated Sangoma Drivers
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I couldn't help noticing that the Sangoma drivers distributed with the
current kernel are slightly out of date and was wondering whether there
was any reason for this?

For example the kernel copy of sdla.c was last updated Mar 20, 2001 while
the version contained in the drivers distributed on sangoma.com[1] was
last updated Dec 15. 2003.

[1] ftp://ftp.sangoma.com/linux/current_wanpipe/
