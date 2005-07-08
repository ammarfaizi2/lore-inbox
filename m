Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVGHMTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVGHMTf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 08:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVGHMTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 08:19:35 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29362 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262591AbVGHMTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 08:19:32 -0400
Date: Fri, 8 Jul 2005 14:19:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pekka Enberg <penberg@gmail.com>
cc: Ram <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, mike@waychison.com, bfields@fieldses.org,
       Miklos Szeredi <miklos@szeredi.hu>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC PATCH 1/8] share/private/slave a subtree
In-Reply-To: <84144f0205070804171d7c9726@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0507081412280.3743@scrub.home>
References: <1120816072.30164.10.camel@localhost>  <1120816229.30164.13.camel@localhost>
  <1120817463.30164.43.camel@localhost> <84144f0205070804171d7c9726@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Jul 2005, Pekka Enberg wrote:

> > +#define PNODE_MEMBER_VFS  0x01
> > +#define PNODE_SLAVE_VFS   0x02
> 
> Enums, please.

Is this becoming a requirement now? I personally would rather leave that 
to personal preference...

bye, Roman
