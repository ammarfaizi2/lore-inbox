Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265158AbUELSPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265158AbUELSPb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUELSPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:15:30 -0400
Received: from smtp4.poczta.onet.pl ([213.180.130.28]:12423 "EHLO
	smtp4.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S265150AbUELSPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:15:17 -0400
From: Marcin Garski <garski@poczta.onet.pl>
Reply-To: garski@poczta.onet.pl
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: SiI3112 Serial ATA - no response on boot
Date: Wed, 12 May 2004 20:14:01 +0200
User-Agent: KMail/1.6.2
References: <200405112052.44979.garski@poczta.onet.pl> <200405121851.42401.garski@poczta.onet.pl> <200405121926.43050.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405121926.43050.bzolnier@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405122014.01443.garski@poczta.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me on replies, I am not subscribed to the list, thanks]

Bartlomiej Zolnierkiewicz wrote:
> > Marco Adurno wrote:
> > > I've got the same problem some time ago.
> > > You have just to appen the string
> > > hdg=none
> > > in your boot loader config file
> >
> > Thanks, that's working.
> > But isn't that a workaround for problem with probe (on NON SATA HDD
> > probe don't generate such errors) that should be fixed somehow?
>
> Yes, feel free to fix it. ;-)

Maybe in future. Now i'am learning how to hack kernel (i would like to 
write or fix some device driver, like you :) ) but currently i'm a 
total newbie :(
-- 
Best Regards
Marcin Garski
