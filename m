Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVAEJ3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVAEJ3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVAEJ3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:29:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:60598 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262315AbVAEJ2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:28:21 -0500
Date: Wed, 5 Jan 2005 01:27:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: tytso@mit.edu, davidsen@tmr.com, bunk@stusta.de, diegocg@teleline.es,
       willy@w.ods.org, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-Id: <20050105012709.5c970983.akpm@osdl.org>
In-Reply-To: <200501032113.j03LDWsa004885@laptop11.inf.utfsm.cl>
References: <20050103183621.GA2885@thunk.org>
	<200501032113.j03LDWsa004885@laptop11.inf.utfsm.cl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>
> Is there any estimate of the number of daily-straight-from-BK users?

fwiw, it seems that there were ~1200 downloads of 2.6.10-rc2-mm4 from
kernel.org.  Almost all via http - only 20 downloads appear in vsftpd.log,
which seems fishy.  The number of downloads via mirrors is unknown.

(randomly chosen) 2.6.10-rc3-bk2 had ~750 downloads from kernel.org, only
eight of them via ftp (?).

bottom line: the number of testers seems to be in the 1000-2000 range.
