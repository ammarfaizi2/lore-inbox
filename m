Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265873AbUACCCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 21:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265878AbUACCCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 21:02:09 -0500
Received: from mx15.sac.fedex.com ([199.81.197.54]:13062 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP id S265873AbUACCCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 21:02:07 -0500
Date: Sat, 3 Jan 2004 09:48:34 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Jens Axboe <axboe@suse.de>
cc: Michael Hunold <hunold@convergence.de>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: GetASF failed on DVD authentication
In-Reply-To: <20040102163024.GS5523@suse.de>
Message-ID: <Pine.LNX.4.58.0401030946550.948@boston.corp.fedex.com>
References: <Pine.LNX.4.58.0401021616580.4954@boston.corp.fedex.com>
 <20040102103949.GL5523@suse.de> <Pine.LNX.4.58.0401022219290.10338@silk.corp.fedex.com>
 <3FF5986C.8060806@convergence.de> <20040102161813.GA21852@suse.de>
 <20040102163024.GS5523@suse.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/03/2004
 10:02:02 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/03/2004
 10:02:04 AM,
	Serialize complete at 01/03/2004 10:02:04 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> BTW Jeff, I'd still very much like to see the usb-storage log from when
> sr gets loaded. Even though it's fine to kill the CDC_DVD checks, it
> would still be a good idea to fix why the capabilities check fails. That
> is the real bug.

Jens,

How else can I help to pin-point the source of this problem?

tstdvd can authenticate the drive now.

Thank again for your help.


Jeff.

