Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265864AbTLIO0X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265870AbTLIOWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:22:37 -0500
Received: from main.gmane.org ([80.91.224.249]:20444 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265867AbTLIOVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:21:16 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Device-mapper submission for 2.4
Date: Tue, 09 Dec 2003 15:21:13 +0100
Message-ID: <yw1x65gqgjhi.fsf@kth.se>
References: <20031209115806.GA472@reti> <Pine.LNX.4.44.0312091113510.1289-100000@logos.cnet>
 <20031209134551.GG472@reti> <yw1xekvegkgg.fsf@kth.se>
 <20031209141026.GC28465@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:jBky9E9vbdP5sOuDWJu8QN5PIeY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> writes:

>> >> I believe 2.6 is the right place for the device mapper. 
>> >
>> > So what's the difference between a new filesystem like XFS and a new
>> > device driver like dm ?
>> 
>> None.  Neither will go into 2.4, if I've understood things
>> correctly.
>
> You haven't been following lkml, I guess. xfs has been merged to 2.4. 

Yes, I see that now.  After Marcelo had said "no" about a hundred
times, I stopped reading anything with xfs in the subject.  I guess I
should have looked a little bit closer at that last subject.

-- 
Måns Rullgård
mru@kth.se

