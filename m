Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWGQRyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWGQRyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 13:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWGQRyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 13:54:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:31972 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751040AbWGQRyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 13:54:10 -0400
Date: Mon, 17 Jul 2006 10:52:19 -0700
From: Greg KH <greg@kroah.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, akpm@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [patch 27/45] tpm: interrupt clear fix
Message-ID: <20060717175219.GA8250@kroah.com>
References: <20060717160652.408007000@blue.kroah.org> <20060717162806.GB4829@kroah.com> <1153155363.4808.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153155363.4808.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 09:56:03AM -0700, Kylene Jo Hall wrote:
> There was a different patch proposed and accepted already for this fix
> based on comments on the list.

Care to send it to the stable@kernel.org address so we can drop this one
and apply the correct one instead?

thanks,

greg k-h
