Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266094AbTFWSrV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266091AbTFWSrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:47:19 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:33805 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266102AbTFWSqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:46:52 -0400
Subject: Re: O(1) scheduler & interactivity improvements
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: John Bradford <john@grabjohn.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030623163234.GA1184@hh.idb.hist.no>
References: <200306231244.h5NCiE1Q000920@81-2-122-30.bradfords.org.uk>
	 <20030623163234.GA1184@hh.idb.hist.no>
Content-Type: text/plain
Message-Id: <1056394844.587.10.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 23 Jun 2003 21:00:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 18:32, Helge Hafting wrote:
> > Well, no, opaque window moving is fine if the CPU isn't at 100%.  If
> > it is, I'd rather see choppy window movements than have a server
> > application starved of CPU.  That's just my preference, though.
> > 
> That could be an interesting hack to a window manager - 
> don't start the move in opaque mode when the load is high.

But there are so many window managers floating out there...

