Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTDYNMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 09:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbTDYNMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 09:12:10 -0400
Received: from customer204.globaltap.com ([206.104.238.204]:49356 "HELO
	annexa.net") by vger.kernel.org with SMTP id S261872AbTDYNMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 09:12:09 -0400
Subject: Re: odd gnome-terminal behavior in 2.5.67-mm3
From: James Strandboge <jamie@tpptraining.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304241518550.31091-100000@sol.cobite.com>
References: <Pine.LNX.4.44.0304241518550.31091-100000@sol.cobite.com>
Content-Type: text/plain
Organization: Targeted Performance Partners, LLC
Message-Id: <1051277058.1588.70.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Apr 2003 09:24:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 15:26, David Mansfield wrote:
> Hi Andrew, list
> 
> I've been experiencing some odd behavior running 2.5.67-mm3 on my RH9 
> based desktop.
> 
> It's probably an application bug, but something strange is happening 
> anyway that doesn't happen in 'stable' kernels.
> 
> What happens is that gnome-terminal gets stuck in some sort of 'infinite 
> loop' when a lot of output is going to the screen and also keypresses are 
> going in (like paging through a large file - holding down pgup/pgdown).
> 
> Xterm doesn't seem to be affected.

I'll chime in and mention that I've seen this too, and also doing a
paste operation via highlight and middle click doesn't work in 2.5
either.  I assumed it was a libvte bug.

Jamie

-- 
James Strandboge
Targeted Performance Partners, LLC
Web: http://www.tpptraining.com
E-mail: jamie@tpptraining.com
Tel: (585) 271-8370
Fax: (585) 271-8373

