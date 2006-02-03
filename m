Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWBCGO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWBCGO2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 01:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWBCGO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 01:14:28 -0500
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:43175 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751196AbWBCGO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 01:14:28 -0500
Message-ID: <43E2F4AE.6070902@namesys.com>
Date: Thu, 02 Feb 2006 22:14:06 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Adrian Ulrich <reiser4@blinkenlights.ch>, reiserfs-list@namesys.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Small ZFS / Reiser4 / Ext 'benchmark'
References: <20060202225943.47804036.reiser4@blinkenlights.ch> <20060202225422.GT11642@schatzie.adilger.int>
In-Reply-To: <20060202225422.GT11642@schatzie.adilger.int>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am surprised that Reiser4 does so well, and I would be interested in
knowing more details of exactly what the test does.  Our tests show
reiser4 not doing THAT much better, so  you must be doing something
different from our tests. 

I learn from almost every benchmark done by other people, because they
almost always test differently from what I had imagined I should test.

Hans
