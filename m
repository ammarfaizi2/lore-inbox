Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVFAUoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVFAUoV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVFAUoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:44:10 -0400
Received: from mxout1.netvision.net.il ([194.90.9.20]:43202 "EHLO
	mxout1.netvision.net.il") by vger.kernel.org with ESMTP
	id S261165AbVFAUQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:16:55 -0400
Date: Wed, 01 Jun 2005 23:50:25 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: problem with ALSA ane intel modem driver
In-reply-to: <20050601214758.037f989a@laptop>
To: Marcin Bis <marcin.bis@students.mimuw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Mail-followup-to: Marcin Bis <marcin.bis@students.mimuw.edu.pl>,
 linux-kernel@vger.kernel.org
Message-id: <20050601205025.GB30376@sashak.softier.local>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <200505280716.46688.cijoml@volny.cz>
 <20050528154736.3ab2550a@laptop> <s5h64x0x2pc.wl@alsa2.suse.de>
 <20050531233712.7b782c6c@laptop> <20050601161745.GB29436@sashak.softier.local>
 <20050601214758.037f989a@laptop>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:47 Wed 01 Jun     , Marcin Bis wrote:
> 
> 1-1/0: Silicon Laboratory Si3036/8 rev 1

This one is supported. The problem is most likely with user-space
slmodem, try recent one (2.9.9d) from
http://linmodems.technion.ac.il/packages/smartlink .

And there are linmodems related list discuss@linmodems.org .

Sasha.
