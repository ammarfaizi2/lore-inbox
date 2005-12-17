Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbVLQUkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVLQUkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVLQUj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:39:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964966AbVLQUjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:39:35 -0500
Date: Sat, 17 Dec 2005 12:39:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>
Subject: Re: OOPs in 2.6.15-rc5-mm2 and -mm3, early boot stage
Message-Id: <20051217123910.eb8ae4cf.akpm@osdl.org>
In-Reply-To: <20051217005511.67749.qmail@web50103.mail.yahoo.com>
References: <20051217005511.67749.qmail@web50103.mail.yahoo.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Thompson <norsk5@yahoo.com> wrote:
>
> [   24.978129] RIP: 0010:[<ffffffff8052da23>] <ffffffff8052da23>{fill_mp_bus_to_cpumask+163}

Jeff played with that function...
