Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLOXfH>; Fri, 15 Dec 2000 18:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbQLOXe5>; Fri, 15 Dec 2000 18:34:57 -0500
Received: from [216.161.55.93] ([216.161.55.93]:44020 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129183AbQLOXes>;
	Fri, 15 Dec 2000 18:34:48 -0500
Date: Fri, 15 Dec 2000 15:05:31 -0800
From: Greg KH <greg@wirex.com>
To: Philipp Schmid <ph.schmid@aon.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bluetooth and linux
Message-ID: <20001215150531.D13897@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Philipp Schmid <ph.schmid@aon.at>, linux-kernel@vger.kernel.org
In-Reply-To: <20001215222524Z129982-439+4126@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001215222524Z129982-439+4126@vger.kernel.org>; from ph.schmid@aon.at on Fri, Dec 15, 2000 at 11:53:58PM +0100
X-Operating-System: Linux 2.2.18-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 11:53:58PM +0100, Philipp Schmid wrote:
> 
> i'm going to buy a notebook in the near future, which supports bluetooth.
> so my question is: is anyone working on bluetooth drivers or do i have to 
> forget about it ?

There's a bluetooth USB driver already in the kernel, and axis has a
nice bluetooth stack for Linux that's under the GPL (see
http://developer.axis.com/software/bluetooth/ for more info on it.)

What kind of bluetooth device is in the notebook?

Hope this helps,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
