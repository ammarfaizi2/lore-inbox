Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265152AbUHMGoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUHMGoe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 02:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269010AbUHMGoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 02:44:34 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:20396 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265152AbUHMGoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 02:44:32 -0400
Subject: Re: excessive swapping
From: Florin Andrei <florin@andrei.myip.org>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
In-Reply-To: <1092379250.2597.14.camel@rivendell.home.local>
References: <1092379250.2597.14.camel@rivendell.home.local>
Content-Type: text/plain
Message-Id: <1092379468.2597.16.camel@rivendell.home.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 23:44:28 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 23:40, Florin Andrei wrote:

> The system is swapping excessively. There's no way the total size of the
> applications exceeds the size of RAM. There's plenty of room to spare,
> yet 16% of the 530MB of swap is used.

Now it's 22% and counting. Way to go. :-(

> With the Fedora 2 kernel, this never happens. I did exactly the same
> things, and there was no excessive swapping. The system feels very
> responsive and fast.

In such situations, there is 0% swapping with the FC2 kernel.

-- 
Florin Andrei

http://florin.myip.org/

