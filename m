Return-Path: <linux-kernel-owner+w=401wt.eu-S1751791AbWLSARN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWLSARN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbWLSARN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:17:13 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:55316 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbWLSARM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:17:12 -0500
Date: Tue, 19 Dec 2006 09:16:25 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, akpm@osdl.org, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org, hch@infradead.org, linux-mm@kvack.org,
       paulus@samba.org, mkravetz@us.ibm.com, gone@us.ibm.com,
       cbe-oss-dev@ozlabs.org
Subject: Re: [PATCH] Fix sparsemem on Cell
Message-Id: <20061219091625.43d45893.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1166483780.8648.26.camel@localhost.localdomain>
References: <20061215165335.61D9F775@localhost.localdomain>
	<20061215114536.dc5c93af.akpm@osdl.org>
	<20061216170353.2dfa27b1.kamezawa.hiroyu@jp.fujitsu.com>
	<200612182354.47685.arnd@arndb.de>
	<1166483780.8648.26.camel@localhost.localdomain>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 15:16:20 -0800
Dave Hansen <haveblue@us.ibm.com> wrote:

> enum context
> {
>         EARLY,
>         HOTPLUG
> };
I like this :)

Thanks,
-Kame

