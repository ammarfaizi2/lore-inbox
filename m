Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTENMFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbTENMFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:05:39 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:35003 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S261919AbTENMFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:05:38 -0400
Date: Wed, 14 May 2003 08:16:11 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Chandrasekhar <chandrasekhar.nagaraj@patni.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Core Dump Report
In-Reply-To: <NHBBIPBFKBJLCPPIPIBCIEGFCAAA.chandrasekhar.nagaraj@patni.com>
Message-ID: <Pine.LNX.4.33.0305140815050.10993-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 May 2003, Chandrasekhar wrote:

> Hi Experts,
>
> I want to obtain the core dump information from the running kernel.
> How can I do so by reading the /proc/kcore file.?
>
> Regards
> Chandrasekhar
> -
>

For all intents and purposes you can treat /proc/kcore as a coredump file
:) . Have a look at kgdb and related tools to interpret it correctly.

Cheers,

Ahmed.

