Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbSKDXwg>; Mon, 4 Nov 2002 18:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbSKDXwg>; Mon, 4 Nov 2002 18:52:36 -0500
Received: from dp.samba.org ([66.70.73.150]:46487 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262959AbSKDXwe>;
	Mon, 4 Nov 2002 18:52:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15815.2399.566974.940599@gargle.gargle.HOWL>
Date: Tue, 5 Nov 2002 10:57:19 +1100
From: Christopher Yeoh <cyeoh@samba.org>
To: "Geoff Gustafson" <geoff@linux.co.intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Open POSIX Test Suite
In-Reply-To: <000a01c28454$56a94b90$7fd40a0a@amr.corp.intel.com>
References: <000a01c28454$56a94b90$7fd40a0a@amr.corp.intel.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geoff,

At 2002/11/4 14:48-0800  Geoff Gustafson writes:
> 
> Contributions of any test cases, review of the work, discussion of the
> approach, etc. are very welcome. Join the development mailing list,
> posixtest-discuss. The initial focus is on Signals, Message Queues, Threads,
> Semaphores, and Clocks & Timers, based on current interests and resources.
> You can help in these areas, or start work on another area of the spec.
> There
> will need to be some uniformity across the suite, but many details have yet
> to
> be worked out, so your involvement in those decisions help a lot.

Have you looked at the LSB test suites yet? They already cover much of
what you plan on writing tests for, though we would welcome any
volunteers who would like to increase the coverage.  Most of the tests
suites are released under the Artistic License, with quite a bit of
the code donated by the Open Group (originally from the Unix
certification tests).

You can find more information about them here:

http://www.linuxbase.org/test

The CVS repository is on SourceForge in the LSB project.

Chris
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
