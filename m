Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131878AbRCVHiA>; Thu, 22 Mar 2001 02:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131887AbRCVHhv>; Thu, 22 Mar 2001 02:37:51 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:4973 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131878AbRCVHhh>; Thu, 22 Mar 2001 02:37:37 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Greg Billock <greg@thebilberry.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel BUG at slab.c:1402! -- 2.4.2-0.1.28 
In-Reply-To: Your message of "Wed, 21 Mar 2001 23:15:14 -0800."
             <3AB9A682.43D20AD7@thebilberry.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Mar 2001 18:36:51 +1100
Message-ID: <32245.985246611@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001 23:15:14 -0800, 
Greg Billock <greg@thebilberry.com> wrote:
>Summary: Hotplugging a USB device causes an unrecoverable kernel Aiee!
>
>Copied from screen after interrupt handler killed, so sorry for
>incompleteness. This
>bug is reproducable so if necessary, I can try it again....

The complete oops report is required, and it needs to be run through
ksymoops.  See Documentation/oops-tracing.txt.

