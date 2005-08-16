Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbVHPLWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbVHPLWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 07:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVHPLWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 07:22:09 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:20701 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932635AbVHPLWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 07:22:08 -0400
Date: Tue, 16 Aug 2005 13:21:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mike Waychison <mikew@google.com>
cc: coywolf@sosdg.org, akpm@osdl.org, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] unexport __mntput()
In-Reply-To: <430014EA.4030404@google.com>
Message-ID: <Pine.LNX.4.61.0508161320510.30973@yvahk01.tjqt.qr>
References: <20050815015357.GA16778@everest.sosdg.org> <430014EA.4030404@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nfsd uses it to serve up nfs exports that don't cross mountpoints (or do, if
> "crossmnt" is specified in /etc/exports.

Is not this called nohide?



Jan Engelhardt
-- 
