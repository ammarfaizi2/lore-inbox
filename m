Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbSJAQ7D>; Tue, 1 Oct 2002 12:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262141AbSJAQ5w>; Tue, 1 Oct 2002 12:57:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45556 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262130AbSJAQ51>;
	Tue, 1 Oct 2002 12:57:27 -0400
Date: Tue, 1 Oct 2002 10:02:46 -0700
From: Greg KH <gregkh@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB OOPS in 2.5.40 ?
Message-ID: <20021001170246.GA15890@us.ibm.com>
References: <200210011654.g91GsaU29508@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210011654.g91GsaU29508@eng2.beaverton.ibm.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.5.39 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 09:54:36AM -0700, Badari Pulavarty wrote:
> Hi,
> 
> I get following Debug Stack while rebooting the machine. (8x P-III).
> Is this USB related ? It is not causing me any trouble, just an
> FYI.

Hm, thought this was fixed (it's a pci_pool issue, not a usb issue).
I'll look into it.

And it's not a oops, just a "warning" :)

thanks,

greg k-h
