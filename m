Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTJUSOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 14:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbTJUSOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 14:14:22 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:54034 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263221AbTJUSN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 14:13:58 -0400
Date: Tue, 21 Oct 2003 19:13:55 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Svetoslav Slavtchev <svetljo@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] radeonfb as module
In-Reply-To: <23586.1066757718@www3.gmx.net>
Message-ID: <Pine.LNX.4.44.0310211912490.32738-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi James,
> i've some related questions :-)
> 
> are you going to merge new radeonfb driver in fbdev bk tree ?
> is the driver in ppc bk tree newer? (i have such impression)
I will end up merging Ben's latest driver. A few things have to be done 
tho to do that (power management code). I just added that today and I will 
be also restoring fbset mode changing support again.


