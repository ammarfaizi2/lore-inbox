Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWBVQNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWBVQNA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWBVQNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:13:00 -0500
Received: from xenotime.net ([66.160.160.81]:21716 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964795AbWBVQM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:12:59 -0500
Date: Wed, 22 Feb 2006 08:12:55 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alan Stern <stern@rowland.harvard.edu>
cc: Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Register atomic_notifiers in atomic context
In-Reply-To: <Pine.LNX.4.44L0.0602221041490.5164-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.58.0602220812120.8025@shark.he.net>
References: <Pine.LNX.4.44L0.0602221041490.5164-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Alan Stern wrote:

>
> P.S. (off-topic): Would it be possible to make the -mm series visible
> through the web interface at <http://www.kernel.org/git/>?

see
http://www.kernel.org/git/?p=linux/kernel/git/smurf/linux-trees.git;a=summary
and scroll down to tags

-- 
~Randy
