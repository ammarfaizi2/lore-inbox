Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbUC1HdV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 02:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUC1HdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 02:33:21 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:42675 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262089AbUC1HdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 02:33:18 -0500
Message-ID: <40667FAB.2090802@stesmi.com>
Date: Sun, 28 Mar 2004 09:32:59 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com>
In-Reply-To: <406616EE.80301@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff.

> I'm about to add a raft of SATA-2 hardware, all of which are queued. The 
> standard depth is 32, but one board supports a whopping depth of 256.

Speaking of which .. I just read an announcement that someone (of course
the name eludes me) announced a DVD Burner that's SATA.

Found it:

http://www.plextor.com/english/news/press/712SA_pr.htm

a) Are there provisions in the SATA (1) SPEC for support of
non-disk units?

b) if (strcmp(a, "no"))
      Do you know anything about it, ie is it SATA1 or 2 or what?

c) Let's ponder one gets a unit like this - is it usable with
libata yet?

d) if (strcmp(c, "no"))
      Will it? :)

// Stefan
