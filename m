Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbSLXVnF>; Tue, 24 Dec 2002 16:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265890AbSLXVnF>; Tue, 24 Dec 2002 16:43:05 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:4356
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S265886AbSLXVnE>; Tue, 24 Dec 2002 16:43:04 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Greg KH <greg@kroah.com>
Subject: Re: [PROBLEM][2.5.52/53][USB] USB Device unusable
Date: Tue, 24 Dec 2002 16:52:44 -0500
User-Agent: KMail/1.5.9
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200212241533.21347.spstarr@sh0n.net> <20021224204029.GB3052@kroah.com>
In-Reply-To: <20021224204029.GB3052@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200212241652.45041.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.53-mm1 compiled w/ lm_sensors merged in:

Same error however new thing:

When a non-root user tries to configure the USB device the userland program 
returns 'Unable to claim USB device'

When a root user tries to it reports the same errors as in the previous email.

Shawn.

On Tuesday 24 December 2002 3:40 pm, Greg KH wrote:
> On Tue, Dec 24, 2002 at 03:33:21PM -0500, Shawn Starr wrote:
> > * NOTE: This is -mm2. I will be compiling 2.5.53 (-mm1) today and test
> > this as well.
>
> Please let us know how 2.5.53 works, as there were a number of ehci
> patches in it that might have helped.
>
> thanks,
>
> greg k-h


