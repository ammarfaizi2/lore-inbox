Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWAQQxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWAQQxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWAQQxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:53:36 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:63874 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932204AbWAQQxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:53:36 -0500
Date: Tue, 17 Jan 2006 17:53:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] changes about Call Trace:
In-Reply-To: <200601162322.36979.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0601171752330.18569@yvahk01.tjqt.qr>
References: <20060116121611.GA539@miraclelinux.com> <200601161322.12209.ak@suse.de>
 <20060116134109.GA6707@miraclelinux.com> <200601162322.36979.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > The x86-64 format is more compact.
>> 
>> How about this update?
>> 
>> 1/3: change from "[<...>]" to  "<...>".
>> 2/3: change the format of offset from hexadecimal to decimal in.

i386 should also get these two things.


Jan Engelhardt
-- 
