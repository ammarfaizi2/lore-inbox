Return-Path: <linux-kernel-owner+w=401wt.eu-S1751671AbWLNXA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWLNXA2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWLNXA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:00:28 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:47323 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbWLNXAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:00:25 -0500
Date: Thu, 14 Dec 2006 15:01:03 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, hpa@zytor.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: kernel.org lies about latest -mm kernel
Message-Id: <20061214150103.d42e6990.randy.dunlap@oracle.com>
In-Reply-To: <20061214223718.GA3816@elf.ucw.cz>
References: <20061214223718.GA3816@elf.ucw.cz>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 23:37:18 +0100 Pavel Machek wrote:

> Hi!
> 
> pavel@amd:/data/pavel$ finger @www.kernel.org
> [zeus-pub.kernel.org]
> ...
> The latest -mm patch to the stable Linux kernels is: 2.6.19-rc6-mm2
> pavel@amd:/data/pavel$ head /data/l/linux-mm/Makefile
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 19
> EXTRAVERSION = -mm1
> ...
> pavel@amd:/data/pavel$
> 
> AFAICT 2.6.19-mm1 is newer than 2.6.19-rc6-mm2, but kernel.org does
> not understand that.

and 2.6.20-rc1 should also be listed there.

---
~Randy
