Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVAPOvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVAPOvE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 09:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVAPOvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 09:51:04 -0500
Received: from [220.248.27.114] ([220.248.27.114]:3770 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262519AbVAPOvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 09:51:01 -0500
Date: Sun, 16 Jan 2005 22:46:42 +0800
From: hugang@soulinfo.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm3: swsusp: out of memory on resume (was: Re: Ho ho ho - Linux v2.6.10)
Message-ID: <20050116144641.GA14825@hugang.soulinfo.com>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <200501152220.42129.rjw@sisk.pl> <20050116055420.GA11880@hugang.soulinfo.com> <200501161107.24883.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501161107.24883.rjw@sisk.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 11:07:24AM +0100, Rafael J. Wysocki wrote:
> > 
> > I disable Flush TLB after copy page, It speedup the in qemu, But I can't
> > sure the right thing in real machine, can someone give me point.
> 
> Could you, please, make a patch against -rc1-mm1 with your previous patch
> applied?  It would be much easier to apply. :-)
> 

http://soulinfo.com/~hugang/swsusp/2005-1-16/

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
