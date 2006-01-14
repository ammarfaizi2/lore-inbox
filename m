Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945941AbWANBKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945941AbWANBKb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945942AbWANBKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:10:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39819 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945941AbWANBKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:10:30 -0500
Date: Fri, 13 Jan 2006 17:12:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH/RFT] SATA ACPI objects support
Message-Id: <20060113171225.377c11e5.akpm@osdl.org>
In-Reply-To: <20060113163348.4346ea51.randy_d_dunlap@linux.intel.com>
References: <20060113163348.4346ea51.randy_d_dunlap@linux.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <randy_d_dunlap@linux.intel.com> wrote:
>
> This is the quilt 'combined' patch.  The patch series is also
> available at
>   http://www.xenotime.net/linux/SATA/2.6.16-git9/

It's better all-round if I have the broken-out patches, really.  That way
we're better able to keep track of which of your patches needs to be
patched by a fixup patch.

Could you mail them over please?
