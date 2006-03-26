Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWCZXUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWCZXUK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWCZXUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:20:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:21647 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932191AbWCZXUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:20:08 -0500
Date: Mon, 27 Mar 2006 01:19:11 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Bodo Eggert <7eggert@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
In-Reply-To: <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0603270116150.15593@yvahk01.tjqt.qr>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
 <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Having a SCSI ID is a generic SCSI property
>
>No it's not.
>Havign a SCSI ID is a f*cking idiotic thing to do.
>
>Only [...] think that any such thing even _exists_. 
>It [...] never has, and never will.

Ah. So all the minix, bsd and sun c?t?[dps]? naming is based on what then 
(someone drinking just too much coffe?), if BTL/CTD/HCIL (call it what you 
want) never existed?


Jan Engelhardt
-- 
