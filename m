Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266898AbUHTDjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266898AbUHTDjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 23:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUHTDjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 23:39:46 -0400
Received: from utep.el.utwente.nl ([130.89.16.10]:40591 "EHLO
	utep.el.utwente.nl") by vger.kernel.org with ESMTP id S266366AbUHTDjm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 23:39:42 -0400
Date: Fri, 20 Aug 2004 05:39:37 +0200
From: Anton Starikov <A.Starikov@utwente.nl>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: sata_promise pata connector
Message-Id: <20040820053937.62529c9f@tncms14.tnw.utwente.nl>
In-Reply-To: <20040820031344.GB22682@netnation.com>
References: <20040820031344.GB22682@netnation.com>
Organization: CMS/TN/UT
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-eltn-site-MailScanner-Information: Please contact the administrator, tel. 2826, for more information
X-eltn-site-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unfortunately nothing happen with this PATA port for a long time :)
I' m pretty sure that Jeff have it in ToDo list. But this problem
floating in this list for a long time.  Even he was wiling to do
something with this problem "next week"...but there was always something
more important, that is pretty well understandable. Because if you have
such port on such chip - almost for sure you have some more PATA ports
where you can connect PATA device. But if you have SATA device - and
some SATA card/chip on MB...it still much more important problem,
Because you probably don't have more SATA ports in your HW. And, of
course, almost for sure this port not going to be involved into RAID
business.

Anton.




On Thu, 19 Aug 2004 20:13:44 -0700
Simon Kirby <sim@netnation.com> wrote:

> [ Resend as the last didn't seem to appear on the list... ]
> 
> I've seen it brought up a few times and I believe one email where you
> mention trying it -- what's involved in getting the PATA connector of
> certain Promise SATA chips working?  I'd be willing to hack, test, and
> help in general.
> 
> Thanks,
> 
> Simon-
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
