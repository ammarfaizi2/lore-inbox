Return-Path: <linux-kernel-owner+w=401wt.eu-S932928AbWLNVdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928AbWLNVdK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932932AbWLNVdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:33:09 -0500
Received: from cantor2.suse.de ([195.135.220.15]:54458 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932928AbWLNVdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:33:09 -0500
Date: Thu, 14 Dec 2006 13:32:46 -0800
From: Greg KH <gregkh@suse.de>
To: Michael ODonald <mcodonald@yahoo.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Abolishing the DMCA (was GPL only modules)
Message-ID: <20061214213246.GB9450@suse.de>
References: <561312.27000.qm@web58907.mail.re1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561312.27000.qm@web58907.mail.re1.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 01:09:06PM -0800, Michael ODonald wrote:
> PS: I encourage Greg and all developers who were initially in favor
> of enforcing the GPL-only module policy to stand strong on this
> important issue.

I think you missed the point that my patch prevents valid usages of
non-GPL modules from happening, which is not acceptable.  The GPL comes
into play when the code is distributed, not when it is run.  Because of
this, such a check like I did hurts people who are complying by the GPL
license of the kernel.

thanks,

greg k-h
