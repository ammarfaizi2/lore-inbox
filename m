Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbULGRXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbULGRXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 12:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbULGRXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 12:23:43 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14785 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261840AbULGRXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 12:23:42 -0500
Date: Tue, 7 Dec 2004 18:23:30 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Andy <genanr@emsphone.com>, linux-kernel@vger.kernel.org
Subject: Re: Rereading disk geometry without reboot
In-Reply-To: <41B5C96A.5060909@osdl.org>
Message-ID: <Pine.LNX.4.53.0412071823120.8859@yvahk01.tjqt.qr>
References: <20041206202356.GA5866@thumper2> <Pine.LNX.4.53.0412071240300.18630@yvahk01.tjqt.qr>
 <41B5C96A.5060909@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There's 'blockdev --rereadpt' also, but neither of these work
>on a mounted filesystem afaik.

Who said editing the ptab of something that's mounted is good?



Jan Engelhardt
-- 
ENOSPC
