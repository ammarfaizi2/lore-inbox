Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269761AbTGKByA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 21:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269762AbTGKByA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 21:54:00 -0400
Received: from rth.ninka.net ([216.101.162.244]:7305 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S269761AbTGKBx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 21:53:59 -0400
Date: Thu, 10 Jul 2003 19:08:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74 X.25+LAPB still kills the kernel
Message-Id: <20030710190831.232cebdf.davem@redhat.com>
In-Reply-To: <m37k6qhv8j.fsf@defiant.pm.waw.pl>
References: <m37k6qhv8j.fsf@defiant.pm.waw.pl>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jul 2003 00:28:44 +0200
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> No need to actually use X.25+LAPB, it's enough to just compile it in.

If you post this to linux-net@vger.kernel.org or
netdev@oss.sgi.com, someone might actually read
your bug report.

No network developers listen on linux-kernel.
