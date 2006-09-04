Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWIDKKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWIDKKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 06:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWIDKKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 06:10:38 -0400
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:42655 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1751338AbWIDKKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 06:10:37 -0400
Subject: Re: [stable] [PATCH] Linux 2.6.17.11 - fix compilation error on
	IA64 (try #3)
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Greg KH <gregkh@suse.de>
Cc: Kirill Korotaev <dev@sw.ru>, Greg KH <greg@kroah.com>,
       "Luck, Tony" <tony.luck@intel.com>, akpm@osdl.org, dev@openvz.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net, stable@kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
       xemul@openvz.org
In-Reply-To: <20060829160841.GB9078@suse.de>
References: <617E1C2C70743745A92448908E030B2A72869D@scsmsx411.amr.corp.intel.com>
	 <20060829013137.GA27869@kroah.com> <44F431F5.7020703@sw.ru>
	 <20060829160841.GB9078@suse.de>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Mon, 04 Sep 2006 19:10:34 +0900
Message-Id: <1157364634.3162.8.camel@sebastian.intellilink.co.jp>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 09:08 -0700, Greg KH wrote:
> On Tue, Aug 29, 2006 at 04:24:21PM +0400, Kirill Korotaev wrote:
> > Probably it is my fault, since I thought that patches which got into -stable
> > automatically go into Linus tree.
> 
> No they do not.  Usually it's the requirement that they be in his tree
> first, but I didn't think it was necessary this time due to my
> misunderstanding about the fix.
2.6.18-rc6 has just been released and neither my patch nor the original
patch to which it is a fix seem to have been included. Does this mean
they will not be sent to Linux before the final release of 2.6.18?

Regards,

Fernando


-- 
VGER BF report: H 0.358263
