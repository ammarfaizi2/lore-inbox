Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUIOA34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUIOA34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 20:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269455AbUIOA3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 20:29:01 -0400
Received: from ozlabs.org ([203.10.76.45]:35536 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266128AbUIOAY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 20:24:56 -0400
Date: Wed, 15 Sep 2004 10:20:23 +1000
From: Anton Blanchard <anton@samba.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: Re: offtopic: how to break huge patch into smaller independent patches?
Message-ID: <20040915002023.GD5615@krispykreme>
References: <41474B15.8040302@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41474B15.8040302@nortelnetworks.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Its kind of offtopic, but I hoped that someone might have some pointers 
> since the kernel developers deal with so many patches.
> 
> I've been given a massive kernel patch that makes a whole bunch of 
> conceptually independent changes.
> 
> Does anyone have any advice on how to break it up into independent patches?

dirdiff is a great tool for this. I think its on samba.org somewhere,
but you can definitely find it in debian.

The new version is even better, I think Paul should do a release :)

Anton
