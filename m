Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTLHSli (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTLHSli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:41:38 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:30347 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261217AbTLHSlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:41:37 -0500
To: linux-kernel@vger.kernel.org
Cc: Kendrick Hamilton <hamilton@sedsystems.ca>
Subject: Re: Linux Kernel and GPL section 2c
References: <3FD4BF6E.7070503@sedsystems.ca>
From: Jeremy Maitin-Shepard <jbms@attbi.com>
Date: Mon, 08 Dec 2003 13:43:32 -0500
In-Reply-To: <3FD4BF6E.7070503@sedsystems.ca> (Kendrick Hamilton's message
 of "Mon, 08 Dec 2003 12:14:06 -0600")
Message-ID: <87ptezgnfv.fsf@jay.local.invalid>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendrick Hamilton <hamilton@sedsystems.ca> writes:

> Hello all,
>     I noticed the discussion about linux kernel modules that happened last
>     week. I was wondering about something with regards to the linux kernel and
>     Section 2c of the GPL. Why doesn't the kernel on booting print something
>     about the kernel being free software licensed under the GPL, and shouldn't
>     it?

Presumably, 1) the kernel as a whole is not a "modified" work, but
rather at least parts of it are the original work, 2) it does not read
commands interactively when run, 3) it does not normally print such
announcements.

-- 
Jeremy Maitin-Shepard
