Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUH2BaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUH2BaX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 21:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUH2BaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 21:30:23 -0400
Received: from [61.49.235.67] ([61.49.235.67]:41965 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S267508AbUH2BaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 21:30:17 -0400
Date: Sat, 28 Aug 2004 17:20:44 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200408290020.i7T0Kiu16078@adam.yggdrasil.com>
To: greg@kroah.com
Subject: Re: PWC issue
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org, steve@steve-parker.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004 at 09:12:42 -0700, Greg KH wrote:
>On Sat, Aug 28, 2004 at 08:11:00AM -0700, Randy.Dunlap wrote:
>> On Fri, 27 Aug 2004 22:19:19 -0700 Greg KH wrote:
>> 
>> | On Sat, Aug 28, 2004 at 10:50:05AM -0700, Adam J. Richter wrote:
>> | > 
>> | > 	By the way, I have a long running dispute with Greg K-H
>> | > about his refusal so far to remove replace the GPL incompatible
>> | > firmware in certain USB serial drivers with such a user level
>> | > loading mechanism.  Go figure.
>> | 
>> | Send me a patch to do so, and I will apply it (must include userspace
>> | files so that hotplug can load them properly.)
>> | 
>> | The last time we went around about this I rejected it as we were in a
>> | stable kernel series.  As that is now not true, I'm open to the patch.
>> 
>> Which part is now not true?

>The "stable" part.

>Actually in thinking about it some more, we should offer up both options
>for at least 6 months, with a warning that the in-kernel stuff is going
>to be deleted on a specific date.  That gives everyone time to convert
>their userspace utilities to use the new firmware download code.

>Sound good?

>thanks,

>greg k-h

	Since you've cc'ed me soliciting an opinion in a way where
my silence might be misinterpreted as consent, I'll answer, reluctantly,
knowing that you're making me choose between such misinterpretation
and being potentially accused of provoking a flame war.

	Please do not look to me for any kind of implicit endorsement
of what I believe to be your continuing willful contributory copyright
infringement.  Six additional months of it does not "sound good" to me.
I do not condone it, and I never have.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
