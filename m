Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265283AbUGGSWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbUGGSWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUGGSVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:21:45 -0400
Received: from linuxhacker.ru ([217.76.32.60]:5075 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265281AbUGGSUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:20:40 -0400
Date: Wed, 7 Jul 2004 21:20:24 +0300
From: Oleg Drokin <green@clusterfs.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: Re: [0/9] Lustre VFS patches for 2.6
Message-ID: <20040707182024.GK5619@linuxhacker.ru>
References: <20040707124732.GA25877@clusterfs.com> <40EC19C6.9010309@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EC19C6.9010309@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jul 07, 2004 at 11:41:58AM -0400, John Richard Moser wrote:

> Interesting, but what exactly does this do?  Extra performance?  How?
> Extra security?  Avoid deadlocks?

These are just kernel bits necessary for Lustre to work.
Without lustre there should be no noticeable difference.
Lustre is a cluster filesystem and you can get more info about it at
http://www.lustre.org

Bye,
    Oleg
