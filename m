Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278890AbRKIA36>; Thu, 8 Nov 2001 19:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278908AbRKIA3t>; Thu, 8 Nov 2001 19:29:49 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:41424 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278911AbRKIA3a>; Thu, 8 Nov 2001 19:29:30 -0500
Date: Thu, 8 Nov 2001 16:25:59 -0800
From: Greg KH <greg@kroah.com>
To: Tim Pepper <tpepper@vato.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Big USB speed difference when compiled as module (was Re: speed difference between using hard-linked and modular drives?)
Message-ID: <20011108162559.A1632@us.ibm.com>
In-Reply-To: <20011108142412.A19451@vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011108142412.A19451@vato.org>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.15-pre1 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 02:24:12PM -0800, Tim Pepper wrote:
> BTW: is there a way to do USB sniffing in software in linux?  I'd imagine it's
> possible, but just can't find anything that does...

There was a patch on the linux-usb-devel list a few months ago that
contained a patch to do this.  You might check the archives if you're
interested.

thanks,

greg k-h
