Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267711AbUGWNdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267711AbUGWNdu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 09:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267712AbUGWNdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 09:33:50 -0400
Received: from sputnik.senvnet.fi ([80.83.5.69]:56077 "EHLO sputnik.senvnet.fi")
	by vger.kernel.org with ESMTP id S267711AbUGWNdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 09:33:49 -0400
Date: Fri, 23 Jul 2004 16:33:48 +0300 (EEST)
From: Jussi Hamalainen <count@theblah.fi>
X-X-Sender: count@mir.senvnet.fi
To: Peter Santoro <psantoro@att.net>
Cc: linux-kernel@vger.kernel.org
Subject: re: kernel BUG at journal.c:1849! (2.4.26)
In-Reply-To: <410109BF.2070705@att.net>
Message-ID: <Pine.LNX.4.58.0407231630180.22470@mir.senvnet.fi>
References: <410109BF.2070705@att.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004, Peter Santoro wrote:

> I've spent a lot time trying to track down similar 2.4.26 crashes.
>
> Are you running with highmem enabled?

No. Actually I think the crash was caused by faulty hardware in my
case. The box began spontaineously generating more assertion failures
and other really strange problems. I bought a new mobo+cpu+memory
combo and it's been running just fine now with the same kernel
binary.

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.fi ]=-
