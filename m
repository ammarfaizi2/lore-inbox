Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUABA0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUABA0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:26:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:49611 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261965AbUABA0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:26:03 -0500
Date: Thu, 1 Jan 2004 16:26:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
Message-Id: <20040101162643.579af2bf.akpm@osdl.org>
In-Reply-To: <20040102001203.GD1718@actcom.co.il>
References: <20031229183846.GI13481@actcom.co.il>
	<Pine.LNX.4.58.0312291049020.2113@home.osdl.org>
	<20040101235147.GC1718@actcom.co.il>
	<20040101160420.6a326d0a.akpm@osdl.org>
	<20040102001203.GD1718@actcom.co.il>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> wrote:
>
> On Thu, Jan 01, 2004 at 04:04:20PM -0800, Andrew Morton wrote:
> 
> > hmm, how come a whitespace cleanup patch adds nearly 200 lines which have
> > trailing whitespace?
> 
> That would be either xemacs's or indent's fault. Can't be my
> fault. No sir. Anyway, unless whitespace-mode is lying to me now, no
> line has more than at most one character of whitespace added. If it
> bugs you, I'll clean it up - it's a slow night tonight ;-) 

Nah, leave it as is.  I'm just having a little whine.  I added a nifty
trailing-whitespace-detector to patch-scripts a while back and it's telling
me that a *lot* of people use broken editors.

> > Could we please have a description of the substantive changes in
> > this patch?
> 
> Sure thing: 

Thanks.


