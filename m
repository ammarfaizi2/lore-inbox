Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUFNTna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUFNTna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 15:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUFNTmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 15:42:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46840 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263828AbUFNTkr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 15:40:47 -0400
Date: Mon, 14 Jun 2004 14:36:33 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Dave Jones <davej@redhat.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Can we please keep correct date when doing bk checkins?
Message-ID: <20040614193633.GB1436@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040614184523.93825.qmail@web81301.mail.yahoo.com> <20040614193415.GA28002@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614193415.GA28002@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 08:34:15PM +0100, Dave Jones wrote:
> On Mon, Jun 14, 2004 at 11:45:23AM -0700, Dmitry Torokhov wrote:
> 
>  > I noticed that while the sysfs_rename_dir-cleanup changeset was checked
>  > in on May 14, 2004 dathes on the touched files read 2004/10/06 which is
>  > obviously incorrect.
> 
> What makes you think this is incorrect ?
> It's possible whoever checked in that change did it in their repo
> on May 14th, and then Linus pulled the change into his tree on the
> 10th June, which would alter the timestamp.
> 
> 		Dave

It is incorrect as the date is 6th Oct and not 10th June :-(.. I didn't 
know that it error will affect bk changelogs..

Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 61896
