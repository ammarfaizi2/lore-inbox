Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752049AbWG1RH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbWG1RH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbWG1RH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:07:59 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:30336 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1752049AbWG1RH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:07:58 -0400
Date: Fri, 28 Jul 2006 19:06:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: seb@frankengul.org
cc: Adam Henley <adamazing@gmail.com>, debian-sparc@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Weird kernel 2.6.17.[67] behaviour
In-Reply-To: <20060727100727.GA8408@frankengul.org>
Message-ID: <Pine.LNX.4.61.0607281905070.4972@yvahk01.tjqt.qr>
References: <20060726135526.GA11310@frankengul.org> <44C7F794.3080304@frankengul.org>
 <c526a04b0607261641n7f09242h86025282153e4c91@mail.gmail.com>
 <20060727100727.GA8408@frankengul.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>The boot hangs, the cursor (in the framebuffer) stops blinking, nothing
>is displayed, and the machine seems frozen until I hit a key or a button

Hm. Does this happen if you disconnect the monitor and keyboard and instead 
boot with serial console?


Jan Engelhardt
-- 
