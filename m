Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268185AbUIWRFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268185AbUIWRFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268165AbUIWRBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:01:19 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:21224 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S268155AbUIWQ6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:58:49 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jan Dittmer <jdittmer@ppp0.net>
Subject: Re: Is there a user space pci rescan method?
Date: Thu, 23 Sep 2004 19:05:47 +0200
User-Agent: KMail/1.7
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409231849.11597@bilbo.math.uni-mannheim.de> <4152FFA0.9020005@ppp0.net>
In-Reply-To: <4152FFA0.9020005@ppp0.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231905.47279@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> Rolf Eike Beer wrote:
> > Just search the archive of pcihpd-discuss@lists.sourceforge.net for
> > dummyphp, this is the version that works. I'll rediff it soon and hope
> > Greg will accept it this time.
> >
> > Message-Id to search for: <200403120947.13046@bilbo.math.uni-mannheim.de>
>
> You didn't read my p.s. ... I found it and it's working quite nice. Already

Ehm, yes. Sorry, around 1900 local time and no real breakfast until now.

> discovered a bug in dv1394. Just one thing: Can you strip DUMMY- from the
> name in /sys/bus/pci/slots/ ? It's really ugly and you can't mix different
> hotplug drivers anyway.

Sounds reasonable.

Eike
