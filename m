Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbSJJUAg>; Thu, 10 Oct 2002 16:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbSJJUAX>; Thu, 10 Oct 2002 16:00:23 -0400
Received: from holomorphy.com ([66.224.33.161]:57579 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262202AbSJJUAM>;
	Thu, 10 Oct 2002 16:00:12 -0400
Date: Thu, 10 Oct 2002 13:02:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: Fork timing numbers for shared page tables
Message-ID: <20021010200240.GV10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux Memory Management <linux-mm@kvack.org>
References: <167610000.1034278338@baldur.austin.ibm.com> <3DA5D893.CDD2407C@digeo.com> <175360000.1034279947@baldur.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175360000.1034279947@baldur.austin.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 02:59:07PM -0500, Dave McCracken wrote:
> I ran this test in three cases, 2.5.41, 2.5.41-mm2 without share, and
> 2.5.41-mm2 with share.
> Now for the results (all times are in ms):

Hrm, it'd be nice to see how nicely this does things for things like
500GB-sized processes on 64-bit boxen...


Any chance you could pass this test along for randomized benchmark
type stuff?



Thanks,
Bill
