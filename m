Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbVCWGvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbVCWGvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 01:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVCWGvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 01:51:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:37543 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262854AbVCWGuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 01:50:55 -0500
Date: Wed, 23 Mar 2005 07:50:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Carlos Silva <r3pek@r3pek.homelinux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Starting input devices
In-Reply-To: <1111542009.12157.25.camel@localhost>
Message-ID: <Pine.LNX.4.61.0503230750000.21578@yvahk01.tjqt.qr>
References: <1111542009.12157.25.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi guys,
>
>i'm trying to find somethin in the kernel tree and i can't :(

find /usr/src/linux -type f -print0 | xargs -0 grep YOURKEYWORD

>I want to know, where are the input devices (say mice and keyb) are
/drivers/input/
>initialized. Where does the kernel search the bus for this devices?
Somewhere else... :p


Jan Engelhardt
-- 
