Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270365AbTGWOKY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270368AbTGWOKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:10:24 -0400
Received: from mail.kroah.org ([65.200.24.183]:55486 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270365AbTGWOKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:10:19 -0400
Date: Wed, 23 Jul 2003 10:24:02 -0400
From: Greg KH <greg@kroah.com>
To: "Serge A. Suchkov" <ss@e1.bmstu.ru>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Oops report]: 2.6.0-test1-ac1 oops in umount mass-storage device
Message-ID: <20030723142402.GA2664@kroah.com>
References: <03072313251400.10306@XP1700>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03072313251400.10306@XP1700>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 01:25:14PM +0400, Serge A. Suchkov wrote:
> Hi,
> 
> Today I have oops in 2.6.0-test1-ac1, described below.

There are a number of scsi patches floating around that will probably
fix this problem.  You might want to ask about this on the linux-scsi
mailing list.

thanks,

greg k-h
