Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262142AbSJNUir>; Mon, 14 Oct 2002 16:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262164AbSJNUir>; Mon, 14 Oct 2002 16:38:47 -0400
Received: from ns.suse.de ([213.95.15.193]:44555 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262142AbSJNUir> convert rfc822-to-8bit;
	Mon, 14 Oct 2002 16:38:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Robson Paniago de Miranda <Robsonm@mpdft.gov.br>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 0/5] ACL support for ext2/3
Date: Mon, 14 Oct 2002 22:44:39 +0200
User-Agent: KMail/1.4.3
References: <F993807AD0E4D511AF72009027B2268B0147DC1C@saoluis.mpdft>
In-Reply-To: <F993807AD0E4D511AF72009027B2268B0147DC1C@saoluis.mpdft>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210142244.39506.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 October 2002 20:34, Robson Paniago de Miranda wrote:
> I think Andreas Gruenbacher released version 0.8.51 solving a bug in
> which a user could receive the "others" permission if the group
> permissions are zero. There is still time to integrate these changes?

Ted has the patch; it's trivial to fix.

--Andreas.

