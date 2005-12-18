Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbVLRFjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbVLRFjc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 00:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbVLRFjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 00:39:32 -0500
Received: from web50112.mail.yahoo.com ([206.190.39.149]:32957 "HELO
	web50112.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030185AbVLRFjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 00:39:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WC21lvk1692bW8oLrIHQo8eRP3NXew3+cUsHQqOyBuSA+J1kklGz+G4QXSTseKoM/MOx4UT248XLGIvKucBiRAqRbU6KUPW+TQEbEpOSSeUxPuP7J2ureYpK7K6E8bHjORacRXl3E1vz3zQkB1unWgPIierkrDGXCgJexpggigA=  ;
Message-ID: <20051218053931.99054.qmail@web50112.mail.yahoo.com>
Date: Sat, 17 Dec 2005 21:39:31 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [PATCH]  EDAC with new sysfs interface - remove /proc interfaces on  -mm3
To: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E1EnpGy-0003TI-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Bernd Eckenfels <ecki@lina.inka.de> wrote:

> In article <20051218030721.82963.qmail@web50113.mail.yahoo.com> you wrote:
> > +       errors that have occurred on this csrow. This
> > +       c
> 
> i think there is something missing at the end of file.

yeah, sorry about. Thanks for pointing that out. I will reform email and re-post

> 
> BTW: is chipkill, ECC and other features in that area supported by  the modules?

yes, EDAC contains drivers for several memory controllers,and reports on these error detectors you
mentioned. It currently is already in the -mm tree, waiting for this patch.

doug t

> 
> Gruss
> Bernd
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

