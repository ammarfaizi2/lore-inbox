Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270858AbTHFTKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270862AbTHFTKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:10:53 -0400
Received: from smtp.terra.es ([213.4.129.129]:38177 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id S270858AbTHFTKu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:10:50 -0400
Date: Wed, 6 Aug 2003 21:11:01 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Juergen Schmidt <ju@heisec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: security advisories for the kernel
Message-Id: <20030806211101.72031376.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.44.0308060934480.3262-100000@loki.ct.heise.de>
References: <Pine.LNX.4.44.0308060934480.3262-100000@loki.ct.heise.de>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 6 Aug 2003 18:31:31 +0200 (CEST) Juergen Schmidt <ju@heisec.de> escribió:

> I know, that some of you think, it's the task of the distributors, to
> issue security advisories. I disagree: You publish code on kernel.org that
> people use. That code contains security related bugs. You fix them and
> publish corrected code. People expect from you, to issue an advisory
> about the security bugs you have fixed - and imho they are right...

I agree that people must have something to upgrade to. They're said
"update the kernel from your vendor" or "run 2.4.XX-pre which contains
the security fixes"; but a lot of people don't use vendor kernels and
they don't even know that -pre contains fixes. (where is the
announcement if there's one?)

Can't we have a 2.4.22 which has 2.4.21 + only
the security fixes? Or a 2.4-current which contains current kernel +
security fixes + very important fixes.

I can understand that you can't upgrade the kernel each time there's
a security issue, but this time there're a lof of them, and people
*don't* really know what they've to upgrade. They're just waiting
for a release.

Diego Calleja
