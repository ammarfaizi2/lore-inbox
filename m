Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbSJIHUG>; Wed, 9 Oct 2002 03:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbSJIHUF>; Wed, 9 Oct 2002 03:20:05 -0400
Received: from holomorphy.com ([66.224.33.161]:59106 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261306AbSJIHUF>;
	Wed, 9 Oct 2002 03:20:05 -0400
Date: Wed, 9 Oct 2002 00:22:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.41] New version of shared page tables
Message-ID: <20021009072232.GL10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave McCracken <dmccr@us.ibm.com>,
	Linux Memory Management <linux-mm@kvack.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <181170000.1034109448@baldur.austin.ibm.com> <223810000.1034114378@baldur.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223810000.1034114378@baldur.austin.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 04:59:38PM -0500, Dave McCracken wrote:
> Ok, Bill Irwin found another bug.  Here's the 2 lines of change.
> Dave McCracken

Does fine here with that fix and current version vs. -mm + manfred's
slabfix.


Bill
