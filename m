Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270880AbTHCFei (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 01:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270931AbTHCFei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 01:34:38 -0400
Received: from [66.212.224.118] ([66.212.224.118]:63237 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270880AbTHCFeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 01:34:37 -0400
Date: Sun, 3 Aug 2003 01:22:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm3
In-Reply-To: <20030802222839.1904a247.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0308030118580.3473@montezuma.mastecende.com>
References: <20030802152202.7d5a6ad1.akpm@osdl.org>
 <Pine.LNX.4.53.0308030106380.3473@montezuma.mastecende.com>
 <20030802222839.1904a247.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Aug 2003, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> >
> > On Sat, 2 Aug 2003, Andrew Morton wrote:
> > 
> > > . I don't think anyone has reported on whether 2.6.0-test2-mm2 fixed any
> > >   PS/2 or synaptics problems.  You are all very bad.
> > 
> > It works now by disabling CONFIG_MOUSE_PS2_SYNAPTICS
> > 
> 
> err, that's a bug isn't it?

I've had a hard time following the saga behind the synaptics code. I know 
there is some external thing you have to download but never got round to 
doing it. I'll give that a go now too with CONFIG_MOUSE_PS2_SYNAPTICS. 
Colour me lazy...

-- 
function.linuxpower.ca
