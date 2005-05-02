Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVEBUwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVEBUwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 16:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVEBUwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 16:52:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:48089 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261767AbVEBUwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 16:52:20 -0400
Date: Mon, 2 May 2005 13:41:28 -0700
From: Greg KH <greg@kroah.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH] ds1337 2/4
Message-ID: <20050502204128.GD32713@kroah.com>
References: <20050407231820.GC27226@orphique> <okTF4WNV.1112950260.5841330.khali@localhost> <20050408130216.GB7054@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408130216.GB7054@orphique>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 03:02:16PM +0200, Ladislav Michl wrote:
> On Fri, Apr 08, 2005 at 10:51:00AM +0200, Jean Delvare wrote:
> > Yes, this one is OK with me too.
> 
> Ok, here it is with signed off line.
> 
> Use correct macros to convert between bdc and bin. See linux/bcd.h
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Applied, thanks.

greg k-h

