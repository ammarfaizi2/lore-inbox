Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTLLQ2B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTLLQ2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:28:01 -0500
Received: from main.gmane.org ([80.91.224.249]:45476 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261152AbTLLQ1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:27:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
Date: Fri, 12 Dec 2003 17:27:45 +0100
Message-ID: <yw1xad5yxapq.fsf@kth.se>
References: <16345.51504.583427.499297@l.a> <yw1xd6auyvac.fsf@kth.se>
 <Pine.LNX.4.53.0312121000150.10423@chaos> <yw1xy8tixe96.fsf@kth.se>
 <Pine.LNX.4.53.0312121018450.10945@chaos> <yw1xr7zaxd7e.fsf@kth.se>
 <20031212160546.GA6363@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:sFiccxIeE4vmgPyWXydZcNdohu8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec <vandrove@vc.cvut.cz> writes:

> On Fri, Dec 12, 2003 at 04:33:57PM +0100, M?ns Rullg?rd wrote:
>> 
>> I'm running 2.6.0-test11 on a machine with modular floppy driver,
>> without any spinning motors.  I think it boots from floppy before HD,
>> but I'm not certain (can't check right now).
>
> Maybe because you run patched LILO which works around this 2.6.x

GRUB, actually.  Does it mess with the floppy drive?

-- 
Måns Rullgård
mru@kth.se

