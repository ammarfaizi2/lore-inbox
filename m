Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266642AbTGOHhO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 03:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbTGOHhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 03:37:14 -0400
Received: from rth.ninka.net ([216.101.162.244]:25484 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S266642AbTGOHhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 03:37:13 -0400
Date: Tue, 15 Jul 2003 00:52:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: "B. D. Elliott" <bde@nwlink.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stime/Settimeofday are still broken
Message-Id: <20030715005200.63a151f4.davem@redhat.com>
In-Reply-To: <20030715071826.A891F6AB63@smtp4.pacifier.net>
References: <20030715071826.A891F6AB63@smtp4.pacifier.net>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 00:40:49 -0700
"B. D. Elliott" <bde@nwlink.com> wrote:

> The problems described below still exist in -2.6.0-test1.

Not surprising, since you didn't even CC: the sparc
development list :-)
