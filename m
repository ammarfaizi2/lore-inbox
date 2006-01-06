Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbWAFHO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWAFHO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbWAFHO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:14:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:3722 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932610AbWAFHO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:14:59 -0500
Date: Fri, 6 Jan 2006 08:14:53 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: 7eggert@gmx.de
cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org
Subject: Re: 80 column line limit?
In-Reply-To: <E1EuZWy-0001FP-5j@be1.lrz>
Message-ID: <Pine.LNX.4.61.0601060812360.22809@yvahk01.tjqt.qr>
References: <5rD2D-xs-11@gated-at.bofh.it> <E1EuZWy-0001FP-5j@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Can't we relax the 80 column line rule to something more comfortable?
>> These days descriptive variable/function names are much more valuable,
>> I think.
>
>The patches are sent by email, and it's recommended to not exceed the
>76-character-limit within email.
>
That won't work. There is always something that makes it impossible to have 
an entire mail with patch fit in 76 cols (unless you uuencode), simply 
because the diff headers like the ===, --- and +++ lines may be longer, the 
more even when a timestamp is provided.
However, I do not vote against timestamps, but diff puts them automatically 
in and I am fine with all that.



Jan Engelhardt
-- 
