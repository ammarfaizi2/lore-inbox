Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290657AbSARKRH>; Fri, 18 Jan 2002 05:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290655AbSARKQ7>; Fri, 18 Jan 2002 05:16:59 -0500
Received: from jjvriezen.xs4all.nl ([213.84.113.241]:33165 "HELO xwing.home")
	by vger.kernel.org with SMTP id <S290654AbSARKQs>;
	Fri, 18 Jan 2002 05:16:48 -0500
Date: Fri, 18 Jan 2002 11:17:28 +0100 (CET)
From: Koos Vriezen <koos.vriezen@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Power off NOT working, kernel 2.4.16
Message-ID: <Pine.LNX.4.33.0201181110030.30018-100000@xwing.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I keep having this problem with 2.2 and 2.4 kernel series, and that is
> APM poweroff not working. I tried all possible boot time commands

Did you try apm's power-off option,
modprobe apm power-off, or add option apm power-off in modules.conf or
use lilo's append apm=power-off.

Regards,

Koos Vriezen


