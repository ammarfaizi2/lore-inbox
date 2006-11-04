Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965586AbWKDSV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965586AbWKDSV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 13:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965587AbWKDSV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 13:21:58 -0500
Received: from mail.suse.de ([195.135.220.2]:43664 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965586AbWKDSV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 13:21:57 -0500
Date: Sat, 4 Nov 2006 10:21:44 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       David Brownell <david-b@pacbell.net>, arnd@arndb.de,
       linux-usb-devel@lists.sourceforge.net, discuss@x86-64.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Linux 2.6.19-rc4: known unfixed regressions (v2)
Message-ID: <20061104182144.GD1399@suse.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061103024132.GG13381@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061103024132.GG13381@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 03:41:32AM +0100, Adrian Bunk wrote:
> Subject    : USB net drivers: missing MII select's
> References : http://lkml.org/lkml/2006/10/25/209
> Submitter  : Randy Dunlap <randy.dunlap@oracle.com>
> Caused-By  : Arnd Bergmann <arnd@arndb.de>
>              commit c41286fd42f3545513f8de9f61028120b6d38e89
> Handled-By : Randy Dunlap <randy.dunlap@oracle.com>
>              David Brownell <david-b@pacbell.net>
> Status     : patches are being discussed

This is fixed in Linus's tree already.  If it's somehow insufficient,
please let me know.

thanks,

greg k-h
