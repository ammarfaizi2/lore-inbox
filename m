Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265397AbUEUGWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265397AbUEUGWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 02:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUEUGWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 02:22:30 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:57524 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S265397AbUEUGW3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 02:22:29 -0400
To: sziwan@hell.org.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI interrupts on Asus
References: <20040521030255.GA16390@mcelrath.org>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Fri, 21 May 2004 08:22:26 +0200
In-Reply-To: <20040521030255.GA16390@mcelrath.org> (Bob McElrath's message
 of "Thu, 20 May 2004 20:02:55 -0700")
Message-ID: <yw1xhduab8pp.fsf@ford.guide>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob McElrath <bob@mcelrath.org> writes:

> You both indicated on the LKML list that you have an ASUS laptop and
> after a suspend, ACPI interrupts are not received.  It seems no
> resolution to this is posted on the LKML list.  Have either of you
> figured out how to fix this?

I haven't had time to mess around with those things.  For me, S1
works, but after waking up, the extra buttons only work once each.
Closing and opening the lid makes them work one more time.

S3 seems to work, but the screen doesn't come back on, so it's quite
useless.

-- 
Måns Rullgård
mru@kth.se
