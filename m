Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbRFYIgo>; Mon, 25 Jun 2001 04:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbRFYIge>; Mon, 25 Jun 2001 04:36:34 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:29196 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262660AbRFYIgX>;
	Mon, 25 Jun 2001 04:36:23 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reg Kernel Debugger kdb 
In-Reply-To: Your message of "Mon, 25 Jun 2001 12:41:53 +0530."
             <Pine.LNX.4.10.10106251238230.28707-100000@blrmail> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Jun 2001 18:36:15 +1000
Message-ID: <29330.993458175@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001 12:41:53 +0530 (IST), 
"SATHISH.J" <sathish.j@tatainfotech.com> wrote:
>I would like to use a kernel debugger to set some breakpoints in some
>of the kernel functions. In SVR4 and unixware we use kdb. What is its
>equivalent in linux? Please tell me where the kernel debugger can be
>downloaded for linux.

ftp://oss.sgi.com/projects/kdb/download.  The man pages are in the
patch, in Documentation/kdb/...

