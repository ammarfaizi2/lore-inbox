Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbSIRS0y>; Wed, 18 Sep 2002 14:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268983AbSIRS0x>; Wed, 18 Sep 2002 14:26:53 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:33738 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S268940AbSIRS0x>;
	Wed, 18 Sep 2002 14:26:53 -0400
Date: Wed, 18 Sep 2002 20:31:54 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918183154.GB14629@win.tue.nl>
References: <Pine.LNX.4.44.0209180024090.30913-100000@localhost.localdomain> <20020918123206.GA14595@win.tue.nl> <20020918144939.GU3530@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020918144939.GU3530@holomorphy.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 07:49:39AM -0700, William Lee Irwin III wrote:

> Basically, the nondeterministic behavior of these things is NMI oopsing
> my machines and those of users (who often just cut the power instead of
> running the NMI oopser). get_pid() is actually not the primary offender,
> but is known to be problematic along with the rest of them.

Sorry - I cannot parse this. Who are "these things" and "them"?
