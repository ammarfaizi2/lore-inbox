Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265763AbUF2OXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUF2OXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 10:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUF2OXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 10:23:38 -0400
Received: from mailgate1.siemens.ch ([194.204.64.131]:31260 "EHLO
	mailgate1.siemens.ch") by vger.kernel.org with ESMTP
	id S265763AbUF2OXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 10:23:35 -0400
From: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Organization: Siemens Schweiz AG
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Tue, 29 Jun 2004 16:23:03 +0200
User-Agent: KMail/1.6
Cc: t.hirsch@web.de, laflipas@telefonica.net, linux-kernel@vger.kernel.org
References: <20040625140214.65080.qmail@web81307.mail.yahoo.com>
In-Reply-To: <20040625140214.65080.qmail@web81307.mail.yahoo.com>
X-Face: 9PH_I\aV;CM))3#)Xntdr:6-OUC=?fH3fC:yieXSa%S_}iv1M{;Mbyt%g$Q0+&K=uD9w$8bsceC[_/u\VYz6sBz[ztAZkg9R\txq_7]J_WO7(cnD?s#c>i60S
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406291623.03076.Marc.Waeckerlin@siemens.com>
X-OriginalArrivalTime: 29 Jun 2004 14:23:06.0738 (UTC) FILETIME=[989A1D20:01C45DE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 25. Juni 2004 16.02 schrieb Dmitry Torokhov unter "Re: Continue: 
psmouse.c - synaptics touchpad driver sync problem":
> Anyway, I also have a tiy patch to try out (attached, not tested/
> not compiled). Please let me know how ifit makes any improvement.

Sorry for the delay.

No, unfortunately no improvement at all.

I tested with no special kernel option (no i8042.nodemux or similar).


Regards
Marc
