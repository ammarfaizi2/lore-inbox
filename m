Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268705AbTGIX3G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268709AbTGIX3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:29:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28850
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268705AbTGIX26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:28:58 -0400
Subject: Re: ->direct_IO API change in current 2.4 BK
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: trond.myklebust@fys.uio.no
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <16140.25619.963866.474510@charged.uio.no>
References: <20030709133109.A23587@infradead.org>
	 <Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>
	 <16140.24595.438954.609504@charged.uio.no>
	 <200307092041.42608.m.c.p@wolk-project.de>
	 <16140.25619.963866.474510@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057794049.7133.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jul 2003 00:40:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-09 at 19:50, Trond Myklebust wrote:
> >>>>> " " == Marc-Christian Petersen <m.c.p@wolk-project.de> writes:
> 
>      > err, -aa has XFS per default, -wolk has XFS per default. So
>      > ... ;)
> 
> So they have both XFS + NFS O_DIRECT?

-ac has both


