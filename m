Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbTJUUM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTJUUM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:12:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59780 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263344AbTJUUMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:12:54 -0400
Subject: Re: [PATCH] RH7.3 can't compile 2.6.0-test8 (fs/proc/array.c)
From: Paul Larson <plars@linuxtestproject.org>
To: Marco Roeland <marco.roeland@xs4all.nl>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Norman Diamond <ndiamond@wta.att.ne.jp>
In-Reply-To: <20031021143741.GB22633@localhost>
References: <20031021131915.GA4436@rushmore>
	<20031021135221.GA22633@localhost>  <20031021143741.GB22633@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 Oct 2003 15:12:48 -0500
Message-Id: <1066767169.2360.66.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-21 at 09:37, Marco Roeland wrote:
> Does this compile (and work) for any of you friendly RedHat 7.[23] users? 
> In 2.6.0-test8 yet another argument was added to the monstrous sprintf.
> Perhaps this was just the droplet to overflow gcc-2.96's buckets? Here we
> split it into 3 distinct parts.
Works on my machine.

-Paul Larson


