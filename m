Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTFJI3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 04:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTFJI3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 04:29:44 -0400
Received: from angband.namesys.com ([212.16.7.85]:5297 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262426AbTFJI3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 04:29:43 -0400
Date: Tue, 10 Jun 2003 12:43:23 +0400
From: Oleg Drokin <green@namesys.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 / reiserfs data corruption, 2.5-bk
Message-ID: <20030610084323.GA16435@namesys.com>
References: <20030609193541.GA21106@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609193541.GA21106@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Jun 09, 2003 at 08:35:55PM +0100, Dave Jones wrote:

> 2.5 Bitkeeper tree as of last 24 hrs. Running a lot
> of disk IO stress (multiple fsstress, over 100 fsx instances,
> and random sync calling) produced failures on both reiserfs
> and ext3.
> Tests were done on seperate disks, but concurrently.

Do you have smp or preempt enabled?

Bye,
    Oleg
