Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWEPAsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWEPAsc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 20:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWEPAsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 20:48:32 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:49567 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1750891AbWEPAsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 20:48:31 -0400
Date: Mon, 15 May 2006 17:48:30 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: Mark Hedges <hedges@ucsd.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: unknown io writes in 2.6.16
In-Reply-To: <20060515170943.P3338@network.ucsd.edu>
Message-ID: <Pine.LNX.4.64.0605151741320.954@twinlark.arctic.org>
References: <20060510135100.F26270@network.ucsd.edu>
 <72dbd3150605101442o52a62d79va730314bf96dcfdd@mail.gmail.com>
 <20060510225112.T31828@network.ucsd.edu> <Pine.LNX.4.64.0605121012230.7292@twinlark.arctic.org>
 <20060515170943.P3338@network.ucsd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006, Mark Hedges wrote:

> In W2K at any rate, ctl-shift-esc to get the task manager.  
> Processes tab. View Menu > Select Columns.  Sort by column.

heh i already know about that... it's fairly useless though when the disk 
writes are due to logged events going through the same services dll... i 
was looking for something a little more detailed... like the block_dump + 
strace.

-dean
