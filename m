Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbUB0TmR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUB0TmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:42:17 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:20708 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263003AbUB0TmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:42:15 -0500
Date: Sat, 28 Feb 2004 03:42:05 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: root@chaos.analogic.com, "Chris Friesen" <cfriesen@nortelnetworks.com>
Subject: Re: Why no interrupt priorities?
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Helge Hafting" <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com> <403F894C.1050808@nortelnetworks.com> <Pine.LNX.4.53.0402271336010.8356@chaos>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr31noft84evsfm@smtp.pacific.net.th>
In-Reply-To: <Pine.LNX.4.53.0402271336010.8356@chaos>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 13:42:12 -0500 (EST), Richard B. Johnson <root@chaos.analogic.com> wrote:

>
> In the early IBM/AT, there was a port to which a user of
> a shared "edge" interrupt could write. If the interrupt
> line was still asserted, this would generate another edge.
>
> This meant that any ISR needed to know about other users
> of the same interrupt. This is probably why it didn't
> catch on.

Oops, never seen that in the circuit diagrams. Was that an internal prototype?

Regards
Michael

Ooops2 sorry for priv msg, time to have a nap....
