Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbUBKJPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 04:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUBKJPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 04:15:17 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:2825 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S263796AbUBKJPO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 04:15:14 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: James Morris <jmorris@redhat.com>
Subject: Re: selinux related oops on 2.6.3rc1+bk
Date: Wed, 11 Feb 2004 10:15:07 +0100
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <Xine.LNX.4.44.0402102125200.9747-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0402102125200.9747-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402111015.08027.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Wednesday 11 of February 2004 03:26, James Morris napisa³:
> On Wed, 11 Feb 2004, Arkadiusz Miskiewicz wrote:
> > 2.6.3rc1+bunch of patches from bitkeeper tree (so it's almost rc2)
>
> Which patches?
bk patches up to ,,[PATCH] fix OOPS for multiple IDE PCI modules and 
CONFIG_PROC_FS=y''.

> Could you try the latest -mm kernel?
Unfortunately I can't. It's production machine (back on 2.4 kernel right now).

> - James

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
