Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTFBVGX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 17:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbTFBVGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 17:06:23 -0400
Received: from webhaste.com ([64.62.134.242]:53769 "HELO vortex.webhaste.com")
	by vger.kernel.org with SMTP id S263990AbTFBVGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 17:06:20 -0400
Message-ID: <11091.131.89.178.59.1054588011.squirrel@mail.webhaste.com>
Date: Mon, 2 Jun 2003 14:06:51 -0700 (PDT)
Subject: 'unresolved symbol schedule'
From: <esp@pyroshells.com>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.9)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey all,

I'm getting the above error with out of the box SuSE 8.2 when doing an
insmod - which is *really* confusing to me, because I thought
that 'schedule' was a low-level, linux API call and that modules that you
inserted automatically linked with the kernel.

so.. what the hell is going on here? When I say:

insmod <module_name>

what exactly does insmod do to resolve symbols? And how can you figure out
what symbols are present in the kernel itself? ( I suppose, for instance
that SuSE has another name for the schedule system call - but that's
unlinkely since I've seen the error crop up from time to time on usenet.
No
history on how to solve it though :( )

Ed


