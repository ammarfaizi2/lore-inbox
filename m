Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUCQKJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 05:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUCQKJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 05:09:39 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:40976 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261239AbUCQKIo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 05:08:44 -0500
Message-ID: <405823B2.7070500@aitel.hist.no>
Date: Wed, 17 Mar 2004 11:08:50 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm1 reboots before the boot completes
References: <20040316015338.39e2c48e.akpm@osdl.org>
In-Reply-To: <20040316015338.39e2c48e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.5-rc1-mm1 didn't come up for me. It loads, prints a few
early messages.  Then there is a video mode switch as it
brings up the radeon fb console. The pc reboots before the
flatscreen has time to sync, so I don't know exactly where it
goes wrong.  I might be able to try a CRT, they sync faster.

The 2.6.4-mm1 kernel works fine for me, with the same
config (including 4k stacks)

Helge Hafting

