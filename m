Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUATVLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265778AbUATVLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:11:03 -0500
Received: from main.gmane.org ([80.91.224.249]:10706 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265777AbUATVLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:11:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: HPT370 status [2.4/2.6]
Date: Tue, 20 Jan 2004 22:10:56 +0100
Message-ID: <yw1xoesymilb.fsf@ford.guide>
References: <1g0ZG-2q6-15@gated-at.bofh.it> <400D72B5.40705@gmx.at>
 <yw1x4quqo1gx.fsf@ford.guide> <20040120204537.GA6820@mcgroarty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:N0FhtmQgCimnDzm39nGgfRtPQeI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian McGroarty <brian@mcgroarty.net> writes:

> Wilfried Weissmann <Wilfried.Weissmann@gmx.at> writes:
>> Jan De Luyck wrote:
>>> Hello List,
>>> Before I start frying my disks and all, what's the usability status
>>> of the Hightpoint HPT370 ide "raid" controller on linux 2.4 and 2.6?
>>
>> 2.4 is fine if you use the ataraid code. mirroring is not fault
>> tolerant so you would not want to use that.
>
> No problems with 2.4 here.
>
> 2.6 recognizes my 374, which uses the hpt366 driver like the
> 370. However, no devices are being made available from it [1].
>
> If others' experiences are any different, I'd love to hear.

I've been successfully using an hpt374 based board for a year or so.
Right now I'm running Linux 2.6.0 (no reboot after 2.6.1 release).

-- 
Måns Rullgård
mru@kth.se

