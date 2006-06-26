Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWFZOhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWFZOhl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWFZOhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:37:41 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60942 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030244AbWFZOhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:37:40 -0400
Date: Mon, 26 Jun 2006 10:37:38 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jens Axboe <axboe@suse.de>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] block layer: early detection of medium not present
Message-ID: <Pine.LNX.4.44L0.0606261034090.9506-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens:

Do you have any comments on my proposal to combine media-change detection
with no-media-present detection?

http://marc.theaimsgroup.com/?l=linux-kernel&m=114960763313366&w=2

Alan Stern

