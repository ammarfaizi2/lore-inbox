Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVGGQ61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVGGQ61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 12:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVGGQ4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 12:56:25 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:50897
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261491AbVGGQyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 12:54:41 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: <knobi@knobisoft.de>, "'Pekka Enberg'" <penberg@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>,
       "'Pekka Enberg'" <penberg@cs.helsinki.fi>,
       <hdaps-devel@lists.sourceforge.net>
Subject: RE: Head parking (was: IBM HDAPS things are looking up)
Date: Thu, 7 Jul 2005 10:54:20 -0600
Message-ID: <002201c58314$85cd5c60$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20050707163903.83550.qmail@web32605.mail.mud.yahoo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- Pekka Enberg <penberg@gmail.com> wrote:
>
> > On 7/7/05, Martin Knoblauch <knobi@knobisoft.de> wrote:
> > >  Interesting. Same Notebook, same drive. The program say "not
> > parked"
> > > :-( This is on FC2 with a pretty much vanilla 2.6.9 kernel.
> > >
> > > [root@l15833 tmp]# hdparm -i /dev/hda
> > >
> > > /dev/hda:
> > >
> > >  Model=HTS726060M9AT00, FwRev=MH4OA6BA, SerialNo=MRH403M4GS88XB
> >
> > haji ~ # hdparm -i /dev/hda
> >
> > /dev/hda:
> >
> >  Model=HTS726060M9AT00, FwRev=MH4OA6DA, SerialNo=MRH453M4H2A6PB
>
>  OK, different FW levels. After upgrading my disk to MH40A6GA my head
> parks :-) Minimum required level for this disk seems to be A6DA. Hope
> this info is useful.

Martin,

	Simply upgrading your firmware fixed your problem for being to park the
head?

.Alejandro

