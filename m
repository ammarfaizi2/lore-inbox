Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266033AbTLISVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266038AbTLISVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:21:49 -0500
Received: from mail.kroah.org ([65.200.24.183]:37808 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266033AbTLISVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:21:48 -0500
Date: Tue, 9 Dec 2003 10:19:32 -0800
From: Greg KH <greg@kroah.com>
To: Rob Landley <rob@landley.net>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031209181932.GA9461@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <200312082326.17723.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312082326.17723.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 11:26:17PM -0600, Rob Landley wrote:
> 
> Is there a big rollup patch against that adds all the sys/*/dev entries for 
> people who want to try udev?

After I get finished catching up on USB patches that people sent me for
the last month, I'll generate this and post it to lkml.

thanks,

greg k-h
