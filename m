Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268983AbSIRS1a>; Wed, 18 Sep 2002 14:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269058AbSIRS1a>; Wed, 18 Sep 2002 14:27:30 -0400
Received: from holomorphy.com ([66.224.33.161]:53995 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268983AbSIRS11>;
	Wed, 18 Sep 2002 14:27:27 -0400
Date: Wed, 18 Sep 2002 11:27:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918182708.GY3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020918123206.GA14595@win.tue.nl> <Pine.LNX.4.44.0209181452050.19672-100000@localhost.localdomain> <20020918182818.GA14629@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020918182818.GA14629@win.tue.nl>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 08:28:18PM +0200, Andries Brouwer wrote:
> I would prefer to avoid talking about specific solutions as long as
> this is not a problem that occurs in practice (with 30-bit pids).
> I just want to stress: the larger the pid space, the faster your
> computer forks.
> Andries

This does occur in practice.

Bill
