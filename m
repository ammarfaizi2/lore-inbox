Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTFWG5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 02:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbTFWG5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 02:57:07 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:58429 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264052AbTFWG5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 02:57:05 -0400
Date: Mon, 23 Jun 2003 00:11:43 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: torvalds@transmeta.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH]
Message-Id: <20030623001143.0fb2c292.akpm@digeo.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96FB3@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A847E96FB3@orsmsx401.jf.intel.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2003 07:11:11.0312 (UTC) FILETIME=[A022ED00:01C33956]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" <andrew.grover@intel.com> wrote:
>
> Hi Linus, please do a
> 
> 	bk pull http://linux-acpi.bkbits.net/linux-acpi
> 
> This will update the following files:
> 
>  arch/i386/kernel/setup.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> through these ChangeSets:
> 
> <agrover@groveronline.com> (03/06/22 1.1359.1.1)
>    ACPI: make it so acpismp=force works (reported by Andrew Morton)
> 

OK, thanks.

But prior to 2.5.72, CPU enumeration worked fine without acpismp=force. 
Now it is required.  How come?

