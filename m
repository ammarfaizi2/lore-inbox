Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282920AbRLGQsN>; Fri, 7 Dec 2001 11:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282916AbRLGQrn>; Fri, 7 Dec 2001 11:47:43 -0500
Received: from zeke.inet.com ([199.171.211.198]:42393 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S282998AbRLGQqe>;
	Fri, 7 Dec 2001 11:46:34 -0500
Message-ID: <3C10F25C.FACDA516@inet.com>
Date: Fri, 07 Dec 2001 10:46:20 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-10enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linuxlist@visto.com
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel size
In-Reply-To: <3C07FA8E0005C3C2@iso1.vistocorporation.com> (added by
		    administrator@vistocorporation.com)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rohit prasad wrote:
> 
> Hi,
> 
>  I have compiled a kernel on a machine with a partition size of 20GB and am running it there.
> 
>  I ftp'd this kernel to another machine with similar partition size of 20GB but when I run lilo there I get a message "Fatal: Size too Big"
> 
> Why is that.

Guesses:  different versions of lilo, and you're getting the failure on
the older version?  Maybe it's refering to the size of the kernel as
opposed to the disk partition?

Eli
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
