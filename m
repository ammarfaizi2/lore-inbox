Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWH1Uh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWH1Uh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWH1Uh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:37:57 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42514 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751494AbWH1Uh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:37:57 -0400
Date: Mon, 28 Aug 2006 16:37:56 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Change return values from queue_work et al.
Message-ID: <Pine.LNX.4.44L0.0608281635570.6800-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 August 2006, Alan Stern wrote:

> Andrew and Ingo:
> 
> As discussed earlier, the following patches change the representation used 
> for the return values from queue_work(), schedule_work(), and related 
> routines.

Sorry, I messed up the Subject line.  This series contains only 3 patches, 
not 4.

Alan Stern

