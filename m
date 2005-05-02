Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVEBUwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVEBUwf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 16:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVEBUwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 16:52:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:48601 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261769AbVEBUwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 16:52:20 -0400
Date: Mon, 2 May 2005 13:41:17 -0700
From: Greg KH <greg@kroah.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH] ds1337 1/4
Message-ID: <20050502204117.GC32713@kroah.com>
References: <20050407111631.GA21190@orphique> <hOrXV5wl.1112879260.3338120.khali@localhost> <20050407142804.GA11284@orphique> <20050407211839.GA5357@kroah.com> <20050407231758.GB27226@orphique> <20050407233628.GA6703@kroah.com> <20050408130021.GA7054@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408130021.GA7054@orphique>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 03:00:21PM +0200, Ladislav Michl wrote:
> On Thu, Apr 07, 2005 at 04:36:29PM -0700, Greg KH wrote:
> > Oops, you forgot to add a Signed-off-by: line for every patch, as per
> > Documentation/SubmittingPatches.  Care to redo them?
> 
> Here it is (I'm sorry about that).
> 
> Use i2c_transfer to send message, so we get proper bus locking.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Applied, thanks.

greg k-h
