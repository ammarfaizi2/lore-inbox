Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280118AbRKIU6C>; Fri, 9 Nov 2001 15:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280116AbRKIU5n>; Fri, 9 Nov 2001 15:57:43 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:29178
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280114AbRKIU5g>; Fri, 9 Nov 2001 15:57:36 -0500
Date: Fri, 9 Nov 2001 12:57:30 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Anthony Campbell <a.campbell@doctors.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Total lockup with 2.4.14
Message-ID: <20011109125730.B446@mikef-linux.matchmail.com>
Mail-Followup-To: Anthony Campbell <a.campbell@doctors.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011109162934.A515@debian.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011109162934.A515@debian.local>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 04:29:34PM +0000, Anthony Campbell wrote:
> I've had 3 total lockups with kernel 2.4.12 and now one with 2.4.14.
> 
> I was online at the time, using Acroread on this occasion. No key would
> work, nor would the mouse.
> 
> This doesn't seem to happen with the Alan Cox patches, so perhaps it is
> something to do with VM.
> 

Don't assume that.

The -ac patch includes many more things than just the previous VM.

You should include the Oops, if it did oops.

Also, you should include your .config, and a "lspci -vv" of the affected
system.

Mike
