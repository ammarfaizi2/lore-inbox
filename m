Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTEFRrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbTEFRrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:47:09 -0400
Received: from freeside.toyota.com ([63.87.74.7]:63666 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP id S263866AbTEFRrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:47:08 -0400
Message-ID: <3EB7F800.4010404@tmsusa.com>
Date: Tue, 06 May 2003 10:59:28 -0700
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: X unlock bug revisited
References: <Pine.LNX.4.44.0305061141300.1272-100000@oddball.prodigy.com> <20030506085623.4fe97953.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Tue, 6 May 2003 11:50:22 -0400 (EDT) Bill Davidsen <davidsen@tmr.com> wrote:
>
>| Some months ago I noted that a new kernel introduced a failure to be able 
>| to unlock X after locking. Still there in 2.5.69 for RH 7.2, 7.3, and 8.0.
>| 
>| Is there any plan to address whatever causes this problem with a kernel 
>| fix, or is a 2.4 kernel still the way to go if you need to lock X. I 
>| realize many developers work in environments where there's no need.
>
>This still bites me when I use xscreensaver, so I just use the KDE
>screen saver/locker instead.  Eventually the pain level will be too
>much, though.
>

FWIW, I had this problem with late 2.5 kernels
on my 8.0 boxes - after upgrading to RH 9, the
xscreensaver unlocks properly when running
2.5 kernels -

Apparently the xscreensaver shipped with RH
9 contains the fixes - perhaps needed for their
kernel which contains backported 2.5 features?

Smarter folks than me may know more...

Joe

