Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270677AbUJUFOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270677AbUJUFOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270635AbUJUFFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:05:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:38278 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270437AbUJUFCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:02:52 -0400
Date: Wed, 20 Oct 2004 22:00:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Nelson <james4765@verizon.net>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Structural changes for Documentation directory
Message-Id: <20041020220037.2e209907.akpm@osdl.org>
In-Reply-To: <41773D3F.2040801@verizon.net>
References: <4176CFE3.2030306@verizon.net>
	<20041020153058.6de41ed8.akpm@osdl.org>
	<4176EBD8.3050306@verizon.net>
	<20041021042036.GB14189@redhat.com>
	<41773D3F.2040801@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Nelson <james4765@verizon.net> wrote:
>
> Dave Jones wrote:
>  > On Wed, Oct 20, 2004 at 06:51:04PM -0400, Jim Nelson wrote:
>  > 
>  >  > True.  "./2.6-docs" would reflect the the intent of having 
>  >  > version-specific information, with the "./Documentation" directory left 
>  >  > for general information and files of historical interest.
>  > 
>  > version numbers in directories are nearly always a bad idea,
>  > as they always tend to look a bit silly when the subsequent
>  > release is made.
>  > 
>  > 		Dave
>  > 
>  > 
> 
>  But it would also give a clue that the docs are out of date.  Perhaps 
>  later in each developement cycle, there could be an effort to check the 
>  documentation, with a 2.8-docs or 3.0-docs being the result, and dumping 
>  the 2.6-docs into the historical reference directory.
> 
>  Or, the old stuff could be dropped with the new stable release.
> 
>  The other possibility is to have a TODO file with a list of out-of-date 
>  files, and have the removal of the file listing in the TODO file be part 
>  of the patch submission.

It all sounds too complex.  ./docs/ is fine.
