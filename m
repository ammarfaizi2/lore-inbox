Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbTH2C2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 22:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTH2C2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 22:28:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:5307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264297AbTH2C2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 22:28:54 -0400
Date: Thu, 28 Aug 2003 19:32:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: cswingle@iarc.uaf.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4: Unable to handle kernel NULL pointer dereference
Message-Id: <20030828193215.4f18c551.akpm@osdl.org>
In-Reply-To: <Pine.LNX.3.96.1030828220150.466A-100000@gatekeeper.tmr.com>
References: <20030828131019.69a9f3b9.akpm@osdl.org>
	<Pine.LNX.3.96.1030828220150.466A-100000@gatekeeper.tmr.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:
>
> Let's not. If this goes in the Athlon users will get bad performance,
>  reliable operation, and no one will blame anything but the Athlon... If
>  it keeps oopsing hopefully people will complain and it will get fixed.

Tough luck.  It is not acceptable to have -test kernels oopsing all over
the place.

If anyone cares about the performance then they'll fix it for real.  It's
probably unmeasurable anyway.

