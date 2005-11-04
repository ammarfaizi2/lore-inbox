Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVKDXI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVKDXI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbVKDXI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:08:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:31917 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750824AbVKDXIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:08:25 -0500
Date: Fri, 4 Nov 2005 15:06:44 -0800
From: Greg KH <greg@kroah.com>
To: Luke Yang <luke.adi@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Message-ID: <20051104230644.GA20625@kroah.com>
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com> <20051101165136.GU8009@stusta.de> <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com> <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 12:59:14PM +0800, Luke Yang wrote:
> Hi,
> 
>   Does this patch has the chance to be merged? Is anyone reivewing or
> merging it? Anything I can help? Just want to make sure... Thanks a
> lot!

Your patch is 43 thousand lines long.  Please break it up into the
different logical chunks, and document them, and add a signed-off-by:
line, and send them to the proper places/people, as it is documented in
the file, Documentation/SubmittingPatches.

thanks,

greg k-h
