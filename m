Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTLIVvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 16:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbTLIVvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 16:51:42 -0500
Received: from main.gmane.org ([80.91.224.249]:40675 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262327AbTLIVvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 16:51:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: dialectical deprecation Re: cdrecord hangs my computer
Date: Tue, 09 Dec 2003 22:51:38 +0100
Message-ID: <yw1xn0a11wyd.fsf@kth.se>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com> <Pine.LNX.4.58.0312060011130.2092@home.osdl.org>
 <3FD1994C.10607@stinkfoot.org> <20031206084032.A3438@animx.eu.org>
 <Pine.LNX.4.58.0312061044450.2092@home.osdl.org>
 <20031206220227.GA19016@work.bitmover.com>
 <Pine.LNX.4.58.0312061429080.2092@home.osdl.org>
 <20031207110122.GB13844@zombie.inka.de>
 <Pine.LNX.4.58.0312070812080.2057@home.osdl.org>
 <1201390000.1070900656@[10.10.2.4]> <3FD4CF90.3000905@nishanet.com>
 <Pine.LNX.4.58.0312091430320.19636@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:rXPMVh39RXnvsSy9JNNVNptviA4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> writes:

> On Mon, 8 Dec 2003, Bob wrote:
>
>> I'm scared(under-informed) to drop ide-scsi since I'm using 3ware
>> and don't know if just scsi-generic would be enough for that hd
>> controller(needs ide-scsi?  3ware's site doc is not easy to find).
>
> Bob, I don't believe that the 3ware card uses ide-scsi, yes it uses
> IDE drives and looks like a SCSI controller, but that's done in the
> 3ware driver, not by useing ide-scsi.

That is correct.

-- 
Måns Rullgård
mru@kth.se

