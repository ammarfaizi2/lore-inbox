Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWFVHCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWFVHCL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 03:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWFVHCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 03:02:11 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:30965 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751756AbWFVHCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 03:02:10 -0400
Message-ID: <449A4071.50600@namesys.com>
Date: Thu, 22 Jun 2006 00:02:09 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: Andrew Morton <akpm@osdl.org>, Nick Orlov <bugfixer@list.ru>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: bitmap loading related reiserfs changes in 2.6.17-mm1 are broken
References: <20060622032733.GA5158@nickolas.homeunix.com> <20060621204303.47facd01.akpm@osdl.org>
In-Reply-To: <20060621204303.47facd01.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the things about my getting older is that I stopped thinking that
I would ever be anything but a fool, and started looking for ways to
cheat so that being a fool doesn't hurt so much. 

1) record all experiments/benchmarks in some form so that I can find
them later (because 6 months later when I am  thinking I should have
checked XYZ, I won't remember them well enough to be sure of them anymore).

2) have someone review all code and ideas before I give them to a large
audience

3) if some benchmark result doesn't make sense, I don't let go of it
until it does, because chances are high it is the only clue I will ever
get that something bigger than the obscure measurement is wrong in the
code and in my understanding.

There is a remarkable tendency that I have noticed, that the best
scientists in most fields are more quick to assume themselves to need
careful methodology than most others in the field.

I encourage you to figure these things out at a younger age than I
did.;-)  

Hans
