Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272279AbTGYSHL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272248AbTGYSHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:07:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:36023 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272279AbTGYSHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:07:05 -0400
Date: Fri, 25 Jul 2003 14:14:07 -0400
From: Greg KH <greg@kroah.com>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Has this been fixed yet?
Message-ID: <20030725181407.GB2620@kroah.com>
References: <20030725175141.GA3290@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725175141.GA3290@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 11:21:41PM +0530, Balram Adlakha wrote:
> I posted before but nobody seems to have read it.
> I get his _every_time_ I unload emu10k1 (OSS) module on 2.6.0-test1:
> 
> Call Trace:
> [<c018e261>] devfs_remove+0x9e/0xa0

Nope:
	http://bugme.osdl.org/show_bug.cgi?id=963

Feel free to add your comments to this bug to let people know about it.

thanks,

greg k-h
