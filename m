Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbTLIUxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266125AbTLIUxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:53:45 -0500
Received: from main.gmane.org ([80.91.224.249]:47330 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266124AbTLIUxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:53:41 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Date: Tue, 09 Dec 2003 21:53:37 +0100
Message-ID: <yw1xr7zd1zn2.fsf@kth.se>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com>
 <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com>
 <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
 <3FD577E7.9040809@nishanet.com>
 <pan.2003.12.09.09.46.27.327988@dungeon.inka.de> <yw1x4qwai8yx.fsf@kth.se>
 <3FD62DB1.7040205@student.canterbury.ac.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:FH1u9eWadHum1D5k/lrD9T3dY28=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Hunt <ojh16@student.canterbury.ac.nz> writes:

> Måns Rullgård wrote:
>
>> Andreas Jellinghaus <aj@dungeon.inka.de> writes:
>>
>>>maybe add this to the faq?
>>>
>>>Q: devfs did load drivers when someone tried to open() a non existing
>>>device. will sysfs/hotplug/udev do this?
>>>
>>>A: there is no need to.
>>
>> I never like it when the answer is "you don't want to do this".  It
>> makes me think of a certain Redmond based company.
>>
> No... that's MacOS.. it does everything you want it to do... if you
> think otherwise, you're *wrong*,

Quite true, I've never been able to use the old MacOS for more than a
few minutes without a total system crash, only fixable by pulling the
plug.  MacOS is right, I don't want to use it, and it didn't let me.
Perfect.

> although this isn't as applicable in MacOS X...

It didn't crash, but it made me log out very quickly.

-- 
Måns Rullgård
mru@kth.se

