Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbVI3OIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbVI3OIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbVI3OID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:08:03 -0400
Received: from magic.adaptec.com ([216.52.22.17]:61132 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030306AbVI3OIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:08:02 -0400
Message-ID: <433D46B6.1090608@adaptec.com>
Date: Fri, 30 Sep 2005 10:07:50 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Luben Tuikov <ltuikov@yahoo.com>, Arjan van de Ven <arjan@infradead.org>,
       Willy Tarreau <willy@w.ods.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <20050929232013.95117.qmail@web31810.mail.mud.yahoo.com> <Pine.LNX.4.64.0509291730360.3378@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0509291730360.3378@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 14:08:00.0384 (UTC) FILETIME=[5D90F800:01C5C5C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/29/05 20:35, Linus Torvalds wrote:
> And that's my point. Specs are not only almost invariably badly written, 
> they also never actually match reality. 

Linus, the world has changed around you.

Take a look at the SAS spec and then at a SAS chip
implementation, for example.

(We're talking abou T10 specs, right?)

> And that's way _way_ too common. People who ignore reality are sadly not 
> at all unusual.

You are saying I ignored reality?

> Talk about working code that is _readable_ and _works_.

http://linux.adaptec.com/sas/

	Luben
