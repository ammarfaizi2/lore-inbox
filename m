Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWAFHVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWAFHVR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWAFHVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:21:16 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:55468 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932626AbWAFHVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:21:16 -0500
Date: Fri, 6 Jan 2006 08:21:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
In-Reply-To: <E1EuVds-0000n9-00@mars.bretschneidernet.de>
Message-ID: <Pine.LNX.4.61.0601060819380.22809@yvahk01.tjqt.qr>
References: <E1EuVds-0000n9-00@mars.bretschneidernet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I cannot tell if the PS/2 mouse does not work either since I cannot
>start X.

If you have another box, you could ssh in and start X. Or you could start 
"showkey", to see if it's a problem (e.g. empty keymap) that kbd introduces 
during boot.
Therefore, does keyboard work when you boot with the "-b" option?



Jan Engelhardt
-- 
