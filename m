Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbUKFK3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbUKFK3K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 05:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbUKFK3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 05:29:07 -0500
Received: from [61.48.52.143] ([61.48.52.143]:34279 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261359AbUKFK3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 05:29:00 -0500
Date: Sat, 6 Nov 2004 01:20:39 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411060920.iA69Kd700880@adam.yggdrasil.com>
To: cw@f00f.org
Subject: Re: [PATCH] major devfs shrink based on tmpfs and lookup traps
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I have to correct my own posting:
>The lookup
>trap functionality which likely will stay forever (and, by the way, is
>functionality under the new system).

	I have no idea what editor command I used to garble that
sentence that way!  I meant to say:

The lookup trap functionality will likely stay forever (and, by the
way, is ~40% of the line count and object size of the devfs
functionality under the new system).

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
