Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264423AbTKUUKe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 15:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTKUUKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 15:10:34 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:14288 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S264423AbTKUUKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 15:10:31 -0500
Date: Sat, 22 Nov 2003 09:09:51 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Patrick's Test9 suspend code.
In-reply-to: <200311210046.32588.rob@landley.net>
To: rob@landley.net
Cc: Shaheed <srhaque@iee.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1069445391.2086.9.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200311201726.48097.srhaque@iee.org>
 <200311202233.09609.srhaque@iee.org> <1069368082.2239.66.camel@laptop-linux>
 <200311210046.32588.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, I don't :> I'm doing most of the development work on my
Omnibook XE3, which has a 10GB HDD. Nevertheless, I fully agree with
your point.

Regards,

Nigel

On Fri, 2003-11-21 at 19:46, Rob Landley wrote:
> On Thursday 20 November 2003 16:41, Nigel Cunningham wrote:
> 
> > Whenever I switch from testing a 2.4 kernel to testing 2.6, I do a clean
> > boot for precisely this reason. I'd love it if I could just suspend 2.4,
> > boot the new 2.6 kernel, see if it suspends properly (to a different
> > swap, of course) and then resume the original 2.4 kernel. But doing so
> > would only work if I mounted 2.6 entirely read only, which is not what
> > you seem to be planning.
> 
> You could of course have two completely different sets of root and swap 
> partitions, if you have the disk space.  (And either not sharing /home or 
> unmount it before suspending...)
> 
> Assuming you have the disk space, of course. :)
> 
> Rob
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

