Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWFSUYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWFSUYE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWFSUYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:24:03 -0400
Received: from 1wt.eu ([62.212.114.60]:9 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1750856AbWFSUYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:24:02 -0400
Date: Mon, 19 Jun 2006 22:20:04 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060619202004.GA5822@1wt.eu>
References: <20060618223736.GA4965@1wt.eu> <dmlb92lmehf2jufjuk8emmh63afqfmg5et@4ax.com> <20060619040152.GB2678@1wt.eu> <fvbc92higiliou420n3ctjfecdl5leb49o@4ax.com> <20060619080651.GA3273@1wt.eu> <p9qc92t26fu29ib2opsg4l82lju7qmldm9@4ax.com> <20060619092426.GC3472@1wt.eu> <9huc9217opa7sd26q5it13nvos9f9gg2in@4ax.com> <20060619103114.GA3855@1wt.eu> <an0e92h8q32cffd1rcja48fn05j5su4lhd@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an0e92h8q32cffd1rcja48fn05j5su4lhd@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 06:11:25AM +1000, Grant Coady wrote:
> On Mon, 19 Jun 2006 12:31:14 +0200, Willy Tarreau <w@1wt.eu> wrote:
> 
> >Not needed, it really seems that your vim does name the file like this on
> >purpose. I see nothing abnormal right here.
> 
> So testing -rc1 has munched the filesystem, I'll need to reinstall :(

Boot from a CD and force a full e2fsck. It is very smart and will do a very
good job. At most, you'll get new friends in /lost+found. But do not reinstall
for this !

> Thanks,
> Grant.

Regards,
willy

