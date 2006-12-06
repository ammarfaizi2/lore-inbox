Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759126AbWLFFwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759126AbWLFFwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 00:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760209AbWLFFwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 00:52:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59649 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759126AbWLFFwd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 00:52:33 -0500
Date: Tue, 5 Dec 2006 21:52:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Philippe =?ISO-8859-1?B?R3JhbW91bGzp?= <philippe@gramoulle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.19: OOPS upon boot (not always)
Message-Id: <20061205215224.c19436a1.akpm@osdl.org>
In-Reply-To: <20061204221413.D014DEF@philou.gramoulle.local>
References: <20061204221413.D014DEF@philou.gramoulle.local>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 4 Dec 2006 23:14:13 +0100 Philippe Gramoullé <philippe@gramoulle.com> wrote:
> Kernel oops upon boot, but not always. When it boots ok, then PC's working fine.
> 
> [2.] Full description of the problem/report:
> 
> Following the release of the 2.6.19 kernel, i installed it and after few
> reboots , i caught this oops:
> 
> Picture's here : http://philou.org/2.6.19/2.6.19.crash.at.boot.jpg

Boy, that's one obscure oops trace.   Do they all look like that?
If not, please send some more.
