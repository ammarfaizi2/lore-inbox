Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267872AbUHaVY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267872AbUHaVY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUHaVWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:22:43 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:12180 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269162AbUHaVVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:21:48 -0400
Date: Tue, 31 Aug 2004 14:21:29 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Dmitry Golubev <dmitry@mikrotik.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.6.8.1, additional options for embedded systems
Message-Id: <20040831142129.327d2dce.davem@davemloft.net>
In-Reply-To: <200408312255.40511.dmitry@mikrotik.com>
References: <200408312255.40511.dmitry@mikrotik.com>
Organization: DaveM Loft Enterprises
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 22:55:40 +0300
Dmitry Golubev <dmitry@mikrotik.com> wrote:

> - adds option to disable IGMP (that's rarely needed for desktops)

Never used multicast?

In fact, if I had to choose the place where multicast is most
likely to be used it would be the desktop, and certainly not
servers.
