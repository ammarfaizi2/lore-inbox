Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUIPHOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUIPHOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 03:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267545AbUIPHO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 03:14:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48585 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267551AbUIPHKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 03:10:44 -0400
Date: Thu, 16 Sep 2004 09:09:06 +0200
From: Jens Axboe <axboe@suse.de>
To: "Bc. Michal Semler" <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD-ROM can't be ejected
Message-ID: <20040916070906.GK2300@suse.de>
References: <200409160025.35961.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409160025.35961.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16 2004, Bc. Michal Semler wrote:
> Hi,
> 
> it's almost half a year, when I filled this bug report:
> http://bugme.osdl.org/show_bug.cgi?id=2951
> 
> and it still don't work :)
> 
> Can anybody help me?

strace -o some_file eject /dev/hdc

and send some_file in here.

-- 
Jens Axboe

