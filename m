Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263831AbUFNTji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUFNTji (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 15:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUFNTjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 15:39:37 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:1739 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263831AbUFNTiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 15:38:46 -0400
Date: Mon, 14 Jun 2004 14:34:38 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: Can we please keep correct date when doing bk checkins?
Message-ID: <20040614193438.GA1436@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040614184523.93825.qmail@web81301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614184523.93825.qmail@web81301.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 06:52:18PM +0000, Dmitry Torokhov wrote:
> Hi,
> 
> I noticed that while the sysfs_rename_dir-cleanup changeset was checked
> in on May 14, 2004 dathes on the touched files read 2004/10/06 which is
> obviously incorrect.
> 
> It would be great if bk users keep their clocks somewhat reasonable
> synced.
> 
> Dmitry

Hi Dimtry,

It was actually my blunder.. I noticed the change in date after 2-3 days, but 
by that time I have already sent 3-4 mails. Though I didn't checked in to 
bk directly, but probably the wrong date propogated through Greg's merges.
I am sorry for that.. I know I have created confusions for lot many others.

Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 61896
