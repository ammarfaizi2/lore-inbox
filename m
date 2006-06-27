Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWF0OFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWF0OFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWF0OFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:05:20 -0400
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:42444 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S932263AbWF0OFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:05:18 -0400
Message-ID: <44A13AFE.3080107@draigBrady.com>
Date: Tue, 27 Jun 2006 15:04:46 +0100
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: util-linux status
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the status of util-linux?
There doesn't seem to be anything significant
released in about 1.5 years now.

I'm worried about patches getting lost,
especially since there were a large number
of thirdparty bugs/patches referenced in
the changelog for 2004.

Personally I submitted a patch in 2004 that was
merged immediately, then I sent a simple bug fix
early in 2005 that has never been released.

Can we have a mailing list (on vger?) to
at least archive patches and bugs?

This is the timeline over the last while as I see it:

23 Sep 2005 ----------------------------------------2.12r
  cfdisk: fix a segfault with ReiserFS partitions
  umount: disallow -r option for non-root users
20 Jan 2005 ----------------------------------------2.12q
  updated translations
01 Jan 2005 ----------------------------------------Maintainership change
23 Dec 2004 ----------------------------------------2.12p
                           :
                           : many changes in 16 versions
                           :
05 Mar 2004 ----------------------------------------2.12a

Pádraig.
