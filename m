Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275186AbSKEDQq>; Mon, 4 Nov 2002 22:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275191AbSKEDQq>; Mon, 4 Nov 2002 22:16:46 -0500
Received: from dp.samba.org ([66.70.73.150]:2756 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S275186AbSKEDQo>;
	Mon, 4 Nov 2002 22:16:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15815.14470.953780.411641@gargle.gargle.HOWL>
Date: Tue, 5 Nov 2002 14:18:30 +1100
From: Christopher Yeoh <cyeoh@samba.org>
To: Dan Kegel <dkegel@ixiacom.com>
Cc: Geoff Gustafson <geoff@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sglass@us.ibm.com, cyeoh@au1.ibm.com
Subject: Re: [ANNOUNCE] Open POSIX Test Suite
In-Reply-To: <3DC70FC3.6030707@ixiacom.com>
References: <3DC702E1.1050306@ixiacom.com>
	<00fd01c2845e$eb407ee0$7fd40a0a@amr.corp.intel.com>
	<3DC70FC3.6030707@ixiacom.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2002/11/4 16:24-0800  Dan Kegel writes:
> 
> Anyone know what the relationship between the LTP and LSB Posix
> compliance tests are?

The emphasis on what the test suites are trying to achieve does differ
- eg the LSB doesn't have endurance type tests and concentrates more
on writing tests which can be used for certification purposes. And of
course the LSB test suites only cover the areas that the LSB spec
requires.

> Were they both originally derived from the OpenGroup Posix compliance tests?

I don't think the LTP were tests derived from the OpenGroup (though
I'm not that familiar with them).

Chris
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
