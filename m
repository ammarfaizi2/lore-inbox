Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSFVRsh>; Sat, 22 Jun 2002 13:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316826AbSFVRsh>; Sat, 22 Jun 2002 13:48:37 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:44293 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316798AbSFVRsg>; Sat, 22 Jun 2002 13:48:36 -0400
Date: Sat, 22 Jun 2002 19:48:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: David Brownell <david-b@pacbell.net>
cc: Nick Bellinger <nickb@attheoffice.org>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <3D14B2CF.90002@pacbell.net>
Message-ID: <Pine.LNX.4.44.0206221943320.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 22 Jun 2002, David Brownell wrote:

> Why shouldn't there be a $DRIVERFS/net/ipv4@10.42.135.99/... style hookup
> for iSCSI devices?  Using whatever physical addressing the kernel uses
> there, which I assume wouldn't necessarily be restricted to ipv4.

iSCSI devices are uniqely identified by its name. An iSCSI device can be
reachable at multiple ip numbers or they can even change dynamically.

bye, Roman

