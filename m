Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273115AbRIRRxm>; Tue, 18 Sep 2001 13:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273121AbRIRRxc>; Tue, 18 Sep 2001 13:53:32 -0400
Received: from gte1-22.ce.ftel.net ([206.24.95.226]:6030 "EHLO spinics.net")
	by vger.kernel.org with ESMTP id <S273115AbRIRRxR>;
	Tue, 18 Sep 2001 13:53:17 -0400
Date: Tue, 18 Sep 2001 10:53:27 -0700
Message-Id: <200109181753.f8IHrRG22899@spinics.net>
From: spamtrap@spinics.net
Subject: Re: 2.4.9-ac10 hangs on CDROM read error
In-Reply-To: <1000833035.29346.11.camel@nomade>
Organization: S.P.C.A.A.
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel  <xavier.bestel@free.fr> wrote:

>I have an ABit VP6, CDRW as hdc and DVD as hdd (VIA vt82c686b IDE
>driver), with SCSI emulation on top, and when I read either:
>
>- a DVD with a read error in the DVD drive (UDF mounted, ripping)
>
>- a CDR with a read error in the CDRW drive (ISO mounted)
>
>the system hangs - no ping, no sysrq, nothing. no log.
>
>I haven't tried all combinations (I don't like that). It seems like a
>generic IDE CDROM driver bug, and there since several versions.

I had a freeze when I tried to mount a music CD.  Different chipset
though.


