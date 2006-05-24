Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWEXO5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWEXO5P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 10:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWEXO5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 10:57:15 -0400
Received: from zotz.mtu.ru ([195.34.34.227]:15114 "EHLO zotz.mtu.ru")
	by vger.kernel.org with ESMTP id S932154AbWEXO5O (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 24 May 2006 10:57:14 -0400
Subject: Re: [PATCH] updated reiser4 - reduced cpu usage for writes by
	writing more than 4k at a time (has implications for generic write code and
	eventually for the IO layer)
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Alexey Polyakov <alexey.polyakov@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>,
       Nate Diller <ndiller@namesys.com>
In-Reply-To: <6bffcb0e0605231333n612da806j9bd910cba65e3692@mail.gmail.com>
References: <44736D3E.8090808@namesys.com>
	 <b5d90b2a0605231326g5319fea8wb9efef34ee5f7ec6@mail.gmail.com>
	 <6bffcb0e0605231333n612da806j9bd910cba65e3692@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 18:39:46 +0400
Message-Id: <1148481586.6395.25.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Tue, 2006-05-23 at 22:33 +0200, Michal Piotrowski wrote:
> Hi Hans,
> 
> On 23/05/06, Alexey Polyakov <alexey.polyakov@gmail.com> wrote:
> > Hi!
> >
> > I'm actively using Reiser4 on a production servers (and I know a lot
> > of people that do that too).
> > Could you please release the patch against the vanilla tree?
> > I don't think there's a lot of people that will test -mm version,
> > especially on production servers - -mm is a little bit too unstable.
> 
> Any chance to get this patch against 2.6.17-rc4-mm3?
> 

yes, reiser4 updates for latest stock and mm kernels will be out in one
or two days

> Regards,
> Michal
> 

