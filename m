Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVAUDUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVAUDUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 22:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVAUDUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 22:20:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:29837 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262248AbVAUDUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 22:20:10 -0500
Date: Thu, 20 Jan 2005 19:19:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lennert Van Alboom <lennert.vanalboom@ugent.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: possible memleak in 2.6.11-rc1
Message-Id: <20050120191943.0ac5bad5.akpm@osdl.org>
In-Reply-To: <200501191956.48228.lennert.vanalboom@ugent.be>
References: <200501191956.48228.lennert.vanalboom@ugent.be>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Van Alboom <lennert.vanalboom@ugent.be> wrote:
>
> Possible memleak in 2.6.11-rc1?

Please wait for it to happen again and then send the contents of
/proc/meminfo and /proc/slabinfo.

