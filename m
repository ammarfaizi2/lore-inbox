Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267290AbSLRR6Y>; Wed, 18 Dec 2002 12:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267292AbSLRR6Y>; Wed, 18 Dec 2002 12:58:24 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:35324 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S267290AbSLRR6W>; Wed, 18 Dec 2002 12:58:22 -0500
Date: Wed, 18 Dec 2002 10:04:45 -0800
From: Chris Wright <chris@wirex.com>
To: William Lee Irwin III <wli@holomorphy.com>, chris@wirex.com,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: converting cap_set_pg() to for_each_task_pid()
Message-ID: <20021218100445.B21398@figure1.int.wirex.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	chris@wirex.com, greg@kroah.com, linux-kernel@vger.kernel.org
References: <20021218055742.GE12812@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021218055742.GE12812@holomorphy.com>; from wli@holomorphy.com on Tue, Dec 17, 2002 at 09:57:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III (wli@holomorphy.com) wrote:
> I have a pending patch that converts cap_set_pg() to the
> for_each_task_pid() API. Could you review this, and if it
> pass, include it in your tree?

I have no problem with this change.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
