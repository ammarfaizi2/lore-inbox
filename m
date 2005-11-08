Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965355AbVKHD2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965355AbVKHD2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbVKHD2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:28:09 -0500
Received: from xenotime.net ([66.160.160.81]:40069 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932403AbVKHD2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:28:08 -0500
Date: Mon, 7 Nov 2005 19:12:58 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Neil Brown <neilb@suse.de>
Cc: viro@ftp.linux.org.uk, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linuxram@us.ibm.com
Subject: Re: [OT] Re: [PATCH 3/18] allow callers of seq_open do allocation
 themselves
Message-Id: <20051107191258.1104b731.rdunlap@xenotime.net>
In-Reply-To: <17264.6769.472245.973213@cse.unsw.edu.au>
References: <E1EZInj-0001Eh-9T@ZenIV.linux.org.uk>
	<20051107190340.129bc8c3.rdunlap@xenotime.net>
	<17264.6769.472245.973213@cse.unsw.edu.au>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005 14:24:33 +1100 Neil Brown wrote:

> On Monday November 7, rdunlap@xenotime.net wrote:
> > On Tue, 08 Nov 2005 02:01:31 +0000 Al Viro wrote:
> > 
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > Date: 1131401734 -0500
> > 
> > What format is that date in, please?
> > 
> 
>  %s %z
> 
> (as date(1) understands it).

Thanks.  I sorta guessed that after I sent the mail.

> Or was this a rhetorical question, meaning to say "Who in their right
> mind would used that sort of date format on a public mailing list?" :-)

nope  8:)

---
~Randy
