Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271395AbTHDOWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271750AbTHDOWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:22:23 -0400
Received: from h24-86-78-151.ed.shawcable.net ([24.86.78.151]:1408 "HELO
	alpha.home") by vger.kernel.org with SMTP id S271395AbTHDOWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:22:22 -0400
From: "Gordon Larsen" <glarsen@alpha.homedns.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Disk speed differences under 2.6.0
Date: Mon, 4 Aug 2003 08:12:21 -0600
Message-ID: <IBEJLCACHGEIBMFJACBEMEBACLAA.glarsen@alpha.homedns.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <yw1x1xw5jul4.fsf@users.sourceforge.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you

...Gord

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Måns Rullgård
Sent: August 1, 2003 8:56 AM
To: linux-kernel@vger.kernel.org
Subject: Re: Disk speed differences under 2.6.0


"Gordon Larsen" <glarsen@alpha.homedns.org> writes:

> My apologies if this has already been discussed - but has anyone noticed
> disk I/O speed differences under 2.6.0 as compared to 2.4.20?  My system
has

It has been discussed.  The solution is "hdparm -a 512 /dev/...".

--
Måns Rullgård
mru@users.sf.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



