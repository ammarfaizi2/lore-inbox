Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266107AbTFWS5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266109AbTFWS5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:57:49 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:59665 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S266107AbTFWS5s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:57:48 -0400
Date: Mon, 23 Jun 2003 21:17:29 +0200
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler & interactivity improvements
Message-ID: <20030623191729.GA1299@hh.idb.hist.no>
References: <200306231244.h5NCiE1Q000920@81-2-122-30.bradfords.org.uk> <20030623163234.GA1184@hh.idb.hist.no> <1056394844.587.10.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056394844.587.10.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 09:00:45PM +0200, Felipe Alfaro Solana wrote:

> > That could be an interesting hack to a window manager - 
> > don't start the move in opaque mode when the load is high.
> 
> But there are so many window managers floating out there...

No need to patch them all.  Patch your favourite one. :-)

Helge Hafting

