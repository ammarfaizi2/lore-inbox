Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751733AbWD1DZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWD1DZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 23:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWD1DZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 23:25:24 -0400
Received: from mx1.suse.de ([195.135.220.2]:34954 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751733AbWD1DZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 23:25:23 -0400
Date: Thu, 27 Apr 2006 20:23:54 -0700
From: Greg KH <greg@kroah.com>
To: Muthu Kumar <muthu.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: functions named similar (pci_acpi_init)
Message-ID: <20060428032354.GA20578@kroah.com>
References: <7da560840604271637n65106962k180234c116614d94@mail.gmail.com> <20060428000026.GA29421@kroah.com> <7da560840604271727q185af577sb666ac82a33d78d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da560840604271727q185af577sb666ac82a33d78d6@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 05:27:49PM -0700, Muthu Kumar wrote:
> thanks.. How about the following to make the names consistent with others in
> that file:

Looks good to me.  Can you resend it with a proper changelog comments
and a Signed-off-by: so I can apply it?

thanks,

greg k-h
