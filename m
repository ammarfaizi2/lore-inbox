Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbTDOBBK (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 21:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264023AbTDOBBK (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 21:01:10 -0400
Received: from [12.47.58.203] ([12.47.58.203]:55843 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264022AbTDOBBK (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 21:01:10 -0400
Date: Mon, 14 Apr 2003 18:13:02 -0700
From: Andrew Morton <akpm@digeo.com>
To: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Cc: rudmer@legolas.dynup.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       billh@gnuppy.monkey.org
Subject: Re: 2.5.67-mm3
Message-Id: <20030414181302.0da41360.akpm@digeo.com>
In-Reply-To: <20030415010328.GA3299@gnuppy.monkey.org>
References: <20030414015313.4f6333ad.akpm@digeo.com>
	<20030414110326.GA19003@gnuppy.monkey.org>
	<200304141707.45601@gandalf>
	<20030415010328.GA3299@gnuppy.monkey.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Apr 2003 01:12:55.0495 (UTC) FILETIME=[2520CD70:01C302EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (Hui) <billh@gnuppy.monkey.org> wrote:
>
> On Mon, Apr 14, 2003 at 05:13:05PM +0200, Rudmer van Dijk wrote:
> > this patch fixes it. Maybe it is better to move the call to store_edid up 
> > inside the already avilable #ifdef but I'm not sure if that is possible
> 
> Now I'm getting console warning "anticipatory scheduler" at boot time
> and then having it freeze after mounting root read-only.
> 

Could be anything.   Does sysrq not work?

If not, please send me your .config.
