Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUKSQNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUKSQNs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbUKSQNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:13:39 -0500
Received: from fsmlabs.com ([168.103.115.128]:6336 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261474AbUKSQNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:13:14 -0500
Date: Fri, 19 Nov 2004 09:13:12 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: linux dude <dude_linux@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9
In-Reply-To: <20041119091240.4927.qmail@web90006.mail.scd.yahoo.com>
Message-ID: <Pine.LNX.4.61.0411190912360.7201@musoma.fsmlabs.com>
References: <20041119091240.4927.qmail@web90006.mail.scd.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004, linux dude wrote:

> My question is I already did make odlconfig;make;make
> modules;make modules_install; updated grub,image,
> system.map. Is there any thing missing because of
> which
> it is trying to load module from old
> /lib/modules/2.6.4-52/....
> And Why it is not picking up from 2.6.9/.../ .
> 
> Any help would be really appriciated.

Hey Dude,
	What does `cat /proc/version` say?

Zwane

