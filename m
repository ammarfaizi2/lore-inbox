Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264922AbUFCX4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUFCX4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 19:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUFCX4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 19:56:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:32398 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264922AbUFCXzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 19:55:47 -0400
Date: Thu, 3 Jun 2004 16:38:28 -0700
From: Greg KH <greg@kroah.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040603233828.GA27504@kroah.com>
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040602132654.GY2093@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602132654.GY2093@holomorphy.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 06:26:54AM -0700, William Lee Irwin III wrote:
> On Tue, Jun 01, 2004 at 02:15:39AM -0700, Andrew Morton wrote:
> > - NFS server udpates
> > - md updates
> > - big x86 dmi_scan.c cleanup
> > - merged perfctr.  No documentation though :(
> > - cris architecture update
> 
> Fix warnings about various structs declared inside parameter lists and so
> on seen while compiling compat_ioctl.c.

Doesn't apply to my, or a clean -rc2 tree :(

Probably needs to be sent to Vojtech and put in his tree.

thanks,

greg k-h
