Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUA0XXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUA0XXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:23:31 -0500
Received: from [66.62.77.7] ([66.62.77.7]:26001 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S264919AbUA0XXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:23:30 -0500
Subject: Re: NGROUPS 2.6.2rc2
From: Dax Kelson <dax@gurulabs.com>
To: thockin@sun.com
Cc: torvalds@osdl.org,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au
In-Reply-To: <20040127225311.GA9155@sun.com>
References: <20040127225311.GA9155@sun.com>
Content-Type: text/plain
Message-Id: <1075245953.2848.28.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 27 Jan 2004 16:25:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-27 at 15:53, Tim Hockin wrote:
> What think?  Can we get rid of this limit at long last? :)

Aren't the Samba folks asking for this as well?  People using Samba v3
to replace NT4 domains where commonly users belong to many more than 32
groups.

Dax

