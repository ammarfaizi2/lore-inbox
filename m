Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUHTEIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUHTEIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 00:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUHTEIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 00:08:31 -0400
Received: from utep.el.utwente.nl ([130.89.16.10]:32402 "EHLO
	utep.el.utwente.nl") by vger.kernel.org with ESMTP id S266905AbUHTEIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 00:08:25 -0400
Date: Fri, 20 Aug 2004 06:07:53 +0200
From: Anton Starikov <A.Starikov@utwente.nl>
To: Simon Kirby <sim@netnation.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: sata_promise pata connector
Message-Id: <20040820060753.5025d889@tncms14.tnw.utwente.nl>
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

I even wanted to port original driver from promise to 2.6 kernel...but
because at that time it was one of the moments when pata port "is coming
soon", I decided to not spent time for useless thing :)
Later my PATA drive which was connected  to this port has died , so I
have lost interest and migrate to 2.6 kernel without any problems :)

I don't know how it is going now, but...
I still can do it. 

Jeff, has it sense to port that damn driver finally or not?

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
