Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbTLKNY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbTLKNY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:24:28 -0500
Received: from holomorphy.com ([199.26.172.102]:42213 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264930AbTLKNY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:24:27 -0500
Date: Thu, 11 Dec 2003 05:24:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: matti.aarnio@zmailer.org
Cc: mbligh@aracnet.com, Ed Sweetman <ed.sweetman@wmich.edu>,
       Nick Piggin <piggin@cyberone.com.au>, Donald Maner <donjr@maner.org>,
       Raul Miller <moth@magenta.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Message-ID: <20031211132413.GO19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	matti.aarnio@zmailer.org, mbligh@aracnet.com,
	Ed Sweetman <ed.sweetman@wmich.edu>,
	Nick Piggin <piggin@cyberone.com.au>,
	Donald Maner <donjr@maner.org>, Raul Miller <moth@magenta.com>,
	linux-kernel@vger.kernel.org
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <20031211054111.GX8039@holomorphy.com> <1289530000.1071126517@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1289530000.1071126517@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> You're probably thinking of 2:2 split patches.
>> 2:2 splits are at least technically ABI violations, which is probably
>> why this isn't merged etc. Applications sensitive to it are uncommon.
>> Yes, the SVR4 i386 ELF/ABI spec literally mandates 0xC0000000 as the
>> top of the process address space.

On Wed, Dec 10, 2003 at 11:08:38PM -0800, Martin J. Bligh wrote:
> You mean like we place the stack in the "ABI compliant place"? 
> Yeah, right ;-)
> M.

Something odd is happening here; this is the second time I've gotten this
message. I suspect something is wrong with smtp-out2.blueyonder.co.uk

In fact, other messages in this thread are getting resent, too.


-- wli
