Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbTDMDBE (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 23:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbTDMDBE (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 23:01:04 -0400
Received: from jk.sby.abo.fi ([130.232.136.104]:13325 "EHLO gemini.relay")
	by vger.kernel.org with ESMTP id S262846AbTDMDBD (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 23:01:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jan Knutar <jk-lkml@sci.fi>
To: "Timothy Miller" <tmiller10@cfl.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Page compression in lieu of swap?
Date: Sun, 13 Apr 2003 06:12:44 +0300
X-Mailer: KMail [version 1.2]
References: <000d01c30143$ccf54ad0$6801a8c0@epimetheus> <03041303065500.26409@polaris> <001101c30160$5a9ca790$6801a8c0@epimetheus>
In-Reply-To: <001101c30160$5a9ca790$6801a8c0@epimetheus>
MIME-Version: 1.0
Message-Id: <03041306124401.26409@polaris>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyone on the list checked it out?  Is it good?  Any benchmarks
> performed? Do we want it?

Some benchmarks on the site. Seems to have a negative effect on kernel
compiles atleast, on machines with lots of memory... Looks like my 24 meg
gateway might just be on the border to benefit from it, unless its 133Mhz
overdrive processor (33Mhz isa bus.. wee) makes compression too
expensive to be beneficial...
