Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWDLRdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWDLRdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWDLRdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:33:22 -0400
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:7847 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S932279AbWDLRdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:33:21 -0400
Date: Wed, 12 Apr 2006 19:33:20 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata-pata works on ICH4-M
Message-ID: <20060412173320.GI4919@boogie.lpds.sztaki.hu>
References: <443B9EBB.6010607@gmx.net> <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr> <1144832990.1952.20.camel@localhost.localdomain> <Pine.LNX.4.61.0604121153060.12544@yvahk01.tjqt.qr> <1144852703.1952.36.camel@localhost.localdomain> <20060412151930.GH4919@boogie.lpds.sztaki.hu> <Pine.LNX.4.61.0604121730360.11511@yvahk01.tjqt.qr> <87f94c370604120958m7ff116a5h4090701cd4936b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87f94c370604120958m7ff116a5h4090701cd4936b8@mail.gmail.com>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 12:58:30PM -0400, Greg Freemyer wrote:

> IIRC to get hdparm to talk to sata drives via libata you have use:
> 
> hdparm -d ata /dev/sda

No, that's smartctl. -d for hdparm means something entirely different.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
