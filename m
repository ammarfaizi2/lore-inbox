Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUIJCPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUIJCPD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 22:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUIJCPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 22:15:03 -0400
Received: from mf2.realtek.com.tw ([220.128.56.22]:37894 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S267386AbUIJCMa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 22:12:30 -0400
Message-ID: <011001c496db$99dc6aa0$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: "Robert Love" <rml@ximian.com>
Cc: <linux-kernel@vger.kernel.org>
References: <1094723597.2801.8.camel@laptop.fenrus.com> <41408B41.4030306@am.sony.com> <1094751525.6833.61.camel@betsy.boston.ximian.com>
Subject: Re:  Re: What File System supports Application XIP
Date: Fri, 10 Sep 2004 10:12:14 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/09/10 =?Big5?B?pFekyCAxMDoxMzoxOA==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/09/10
 =?Big5?B?pFekyCAxMDoxMzoyMw==?=,
	Serialize complete at 2004/09/10 =?Big5?B?pFekyCAxMDoxMzoyMw==?=
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,
Sorry. I donot quite understand. My English is poor... :-(
Do you mean there wonot be another duplicated text section in RAM when
application in Ramfs is executed?

Regards,
Colin


----- Original Message ----- 
From: "Robert Love" <rml@ximian.com>
To: "Tim Bird" <tim.bird@am.sony.com>
Cc: <arjanv@redhat.com>; "colin" <colin@realtek.com.tw>;
<linux-kernel@vger.kernel.org>
Sent: Friday, September 10, 2004 1:38 AM
Subject: ¡@[*©U§£¶l¥ó*] Re: What File System supports Application XIP


> On Thu, 2004-09-09 at 09:56 -0700, Tim Bird wrote:
>
> > Most other filesystems populate the pagecache with I/O, presumably.
> > In the case of a ramfs, is the page mapped directly from the fs
> > into the pagecache without a copy?
>
> ramfs _is_ pagecache.
>
> it is cool like that.
>
> Robert Love
>
>
>


