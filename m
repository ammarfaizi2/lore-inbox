Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUASPQb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 10:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUASPQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 10:16:31 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:17292 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265215AbUASPQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 10:16:28 -0500
Date: Mon, 19 Jan 2004 09:16:20 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Overlapping MTRRs in 2.6.1
In-Reply-To: <20040119145955.GA22265@redhat.com>
Message-ID: <Pine.LNX.4.58.0401190915210.13504@ryanr.aptchi.homelinux.org>
References: <Pine.LNX.4.58.0401181458080.2194@ryanr.aptchi.homelinux.org>
 <20040119095003.GB8621@redhat.com> <Pine.LNX.4.58.0401190818450.1003@ryanr.aptchi.homelinux.org>
 <20040119145955.GA22265@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004, Dave Jones wrote:

> On Mon, Jan 19, 2004 at 08:19:49AM -0600, Ryan Reich wrote:
>
>  > > Make sure you're loading both the agpgart module, *AND* the
>  > > relevant chipset driver for your board, ie via-agp, intel-agp or the like.
>  >
>  > Thanks, that's what I was doing.  I didn't notice that the system had changed
>  > from 2.4.
>
> It's mentioned in the http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt
> document I wrote, which is 'must read' material if you're coming from 2.4 with
> no idea of what changed from a user point of view.

...which I had intended to read, but forgot.  Incidentally, the mtrr problem is
still present; I just have agp now.

-- 
Ryan Reich
ryanr@uchicago.edu
