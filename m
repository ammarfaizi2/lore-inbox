Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282512AbRKZUi4>; Mon, 26 Nov 2001 15:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282510AbRKZUig>; Mon, 26 Nov 2001 15:38:36 -0500
Received: from [206.196.53.54] ([206.196.53.54]:59061 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S282504AbRKZUiV>;
	Mon, 26 Nov 2001 15:38:21 -0500
Date: Mon, 26 Nov 2001 14:40:29 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: Looking for SCSI test harness
In-Reply-To: <Pine.LNX.4.10.10111261225030.8817-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.40.0111261439100.15983-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Andre Hedrick wrote:

> On Mon, 26 Nov 2001, Oliver Xymoron wrote:
>
> > Anyone have a tool to put a SCSI disk/driver through its paces?  I'm
> > looking for something that can be used for regression testing.
>
> One day I will get around to fixing SCSI to have a low-level diagnostic
> entry point for a test suite, but not time right now ... sorry.

I think the sg interface is actually sufficient for my purposes.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

