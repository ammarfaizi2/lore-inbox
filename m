Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUCJO7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 09:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUCJO7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 09:59:20 -0500
Received: from holomorphy.com ([207.189.100.168]:57100 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262648AbUCJO7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 09:59:17 -0500
Date: Wed, 10 Mar 2004 06:59:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Brice Figureau <brice@daysofwonder.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: PROBLEM: task->tty->driver problem/oops in proc_pid_sta
Message-ID: <20040310145912.GI655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Brice Figureau <brice@daysofwonder.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <48F1C131BD@vcnet.vc.cvut.cz> <20040310144402.GH655@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310144402.GH655@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 03:32:00PM +0200, Petr Vandrovec wrote:
>> wli has a patch, unfortunately for some reason it did not hit
>> main kernel yet. I've put it (without Wli's permission) at 
>> http://platan.vc.cvut.cz/ftp/pub/linux/pidstat.patch.
>> For unknown reason patch did not find its way to Linus's kernel yet,
>> although it renders 2.6.x unusable in any multiuser environment.

On Wed, Mar 10, 2004 at 06:44:02AM -0800, William Lee Irwin III wrote:
> That's unfortunate; I was hoping it would fix the bug. Thanks for
> testing.

Sorry about the misunderstanding. It's good to hear this fixed the bug.
akpm, please apply.


-- wli
