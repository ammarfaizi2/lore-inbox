Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVC1BTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVC1BTq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 20:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVC1BTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 20:19:46 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:50140 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261653AbVC1BTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 20:19:44 -0500
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com, rlrevell@joe-job.com, mark@mtfhpc.demon.co.uk
Content-Type: text/plain
Date: Sun, 27 Mar 2005 20:03:47 -0500
Message-Id: <1111971828.1912.189.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greg k-h writes:
> On Sat, Mar 26, 2005 at 10:30:20PM -0500, Lee Revell wrote:

>> That's the problem, it's not spelled out explicitly anywhere.
>> That file does not address the issue of whether a driver is
>> a "derived work". This is the part he should talk to a lawyer
>> about, right?
>
> How about the fact that when you load a kernel module, it is
> linked into the main kernel image?  The GPL explicitly states
> what needs to be done for code linked in.

This probably fails. Obviously, it's not over until the courts
say so, but...

First of all, the GPL might not be as infectious as you and RMS
wish it to be. There is a limit to what can be a derived work
in copyright law.

Second of all, module loading is not the same as "linking" in
the traditional sense. The GPL was written before Linux had
kernel modules. Don't be so sure a court would rule as you
would like it to rule.

> Also, realize that you have to use GPL licensed header files
> to build your kernel module...

Um, like the printer cartridges and game cartridges with code
in them? Courts have held that it was OK to copy because it was
needed to implement an interface.

Whatever your lawyer may have said was undoubtably influenced
by your biased attempt to describe the technical issues.

Not that I care for proprietary stuff, being a PowerPC user
myself, but spreading unjustified FUD isn't proper behavior.
Neither is it proper to be marking key driver interfaces as
GPL-only. It's far better to just ignore the proprietary stuff.


