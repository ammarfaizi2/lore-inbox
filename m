Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752418AbWAFHJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbWAFHJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbWAFHJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:09:36 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:7357 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752418AbWAFHJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:09:35 -0500
Date: Fri, 6 Jan 2006 08:09:30 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Willy Tarreau <willy@w.ods.org>
cc: Kay Sievers <kay.sievers@vrfy.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: 80 column line limit?
In-Reply-To: <20060106055208.GE7142@w.ods.org>
Message-ID: <Pine.LNX.4.61.0601060807310.22809@yvahk01.tjqt.qr>
References: <20060105130249.GB29894@vrfy.org>
 <84144f020601050532l56c15be1i4938a84f6c212960@mail.gmail.com>
 <20060105211438.GA1408@vrfy.org> <Pine.LNX.4.61.0601052301270.27662@yvahk01.tjqt.qr>
 <20060106055208.GE7142@w.ods.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >It's not about nesting, if that's the reason, the number of tabs
>> >should get a maximum specified instead.
>> >
>> Or we could have the tab width lowered, but I doubt
>> Linus would accept that :)
>
>In fact, one tab could be lowered, it's the first one. Nearly all code
>has at least this tab which is not very useful and would not affect
>readability if reduced to 2 or 4. But it will be difficult to maintain
>a variable tab width, not to mention the alignment problem on the
>second tab.
>
Oh every editor can be patched. Since 4-(wide)-tabs (in general, not just 
at the start) and esp. 2-tabs are dishonored (CodingStyle: "There are 
heretic movements that try to make indentations 4 (or even 2!)"), 6-tabs 
and 3-tabs could be tried. Ahem :).



Jan Engelhardt
-- 
