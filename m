Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTEJR7Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 13:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbTEJR7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 13:59:25 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:47789 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S264463AbTEJR7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 13:59:24 -0400
Date: Sat, 10 May 2003 14:09:54 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <20030510175625.B28820@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0305101405250.24842-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello again Arjan,

Further to the previous reply, a user can simply be denied mincore :) so
no valid information would come to the attacker. I know that there is no
such problem within the allow/deny code so the attack threat can be
minimized further.

Ahmed.

