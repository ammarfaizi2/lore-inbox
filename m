Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTLDTkg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTLDTkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:40:35 -0500
Received: from [200.176.128.100] ([200.176.128.100]:49840 "EHLO
	mail.agrofel.com.br") by vger.kernel.org with ESMTP id S261294AbTLDTke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:40:34 -0500
Subject: Re: Where'd the .config go?
From: Lucio Maciel <lucio.maciel@agrofel.com.br>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031204083331.7660077a.rddunlap@osdl.org>
References: <20031204151852.GB16568@rdlg.net>
	 <20031204083331.7660077a.rddunlap@osdl.org>
Message-Id: <1070566824.30087.2.camel@walker.agrofel.com.br>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Dec 2003 17:40:25 -0200
X-MIMETrack: Itemize by SMTP Server on Agrofel/Agrofel(Release 5.0.11  |July 24, 2002) at
 04/12/2003 17:41:15,
	Serialize by Router on Agrofel/Agrofel(Release 5.0.11  |July 24, 2002) at
 04/12/2003 17:41:21,
	Serialize complete at 04/12/2003 17:41:21
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, 2003-12-04 at 14:33, Randy.Dunlap wrote:
> On Thu, 4 Dec 2003 10:18:52 -0500 "Robert L. Harris" <Robert.L.Harris@rdlg.net> wrote:
> 
> | 
> | 
> | Just compiled 2.4.23-bk3 and noticed that the option to save the .config
> | somewhere in the kernel is missing.  Mistake somewhere or has this been
> | removed?
> 
> It's never been merged in 2.4.x.  Marcelo didn't want it.
> It's in 2.6.x.

There is a reason for this is not in 2.4?
Not essential, but it is a good help.

> There's a 2.4.22-pre patch in this dir that you can try:
>   http://www.xenotime.net/linux/ikconfig/
> 
Again i'll have to patch every kernel, like XFS?
> 
> --
> ~Randy
> MOTD:  Always include version info.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Lucio Maciel
lucio.maciel@agrofel.com.br

