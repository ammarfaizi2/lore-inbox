Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262885AbSKDXY3>; Mon, 4 Nov 2002 18:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262886AbSKDXY3>; Mon, 4 Nov 2002 18:24:29 -0500
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:64273 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S262885AbSKDXY2>; Mon, 4 Nov 2002 18:24:28 -0500
Message-ID: <3DC702E1.1050306@ixiacom.com>
Date: Mon, 04 Nov 2002 15:29:37 -0800
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Geoff Gustafson <geoff@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: re: [ANNOUNCE] Open POSIX Test Suite
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Geoff Gustafson" <geoff@linux.co.intel.com> wrote:
 > I would like to announce a new project to develop and/or
 > assemble a GPL test suite for POSIX APIs.

You are about to duplicate http://ltp.sf.net

I imagine the main difference is you're targeting Posix
compliance rather than LSB compliance.  That seems
like a fairly minor difference that could be
accommodated within the framework of the LTP.

Or do you feel the existing test framework
and tests assembled in LTP are so inadequate that you
need to start an entirely new project doing
essentially the same thing?

(Apologies if you've already answered this question.  I did
check your web page, but didn't see an answer.)
- Dan

