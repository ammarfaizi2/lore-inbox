Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262397AbSJ0NtU>; Sun, 27 Oct 2002 08:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262400AbSJ0NtU>; Sun, 27 Oct 2002 08:49:20 -0500
Received: from ns.suse.de ([213.95.15.193]:36356 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262397AbSJ0NtT> convert rfc822-to-8bit;
	Sun, 27 Oct 2002 08:49:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Subject: Re: [PATCH][RFC] 2.5.42 (2/2): Filesystem capabilities user tool
Date: Sun, 27 Oct 2002 14:55:28 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <87smz3mupw.fsf@goat.bogus.local>
In-Reply-To: <87smz3mupw.fsf@goat.bogus.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210271455.28569.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 October 2002 21:07, Olaf Dietsche wrote:
> This is the change capabilities tool. It is a first cut at "managing"
> capabilities and not very comfortable.

Olaf, please start with reading the capabilities sections in POSIX 
1003.1e/1003.2c draft 17 (withdrawn). There It's available online at 
<http://wt.xpilot.org/publications/posix.1e/>. A number of people have 
already spent a lot of time figuring out how this could work.

--Andreas.
