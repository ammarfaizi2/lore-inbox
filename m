Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263810AbUFKKyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbUFKKyW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 06:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUFKKyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 06:54:21 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:28382 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263810AbUFKKyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 06:54:13 -0400
Date: Fri, 11 Jun 2004 12:53:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: michael@metaparadigm.com, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: [STACK] >3k call path in ide
Message-ID: <20040611105355.GB2376@wohnheim.fh-wedel.de>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de> <40C72B68.1030404@metaparadigm.com> <20040609162949.GC29531@wohnheim.fh-wedel.de> <20040609122721.0695cf96.akpm@osdl.org> <20040610225938.GF3340@wohnheim.fh-wedel.de> <20040610161021.7997ad9d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040610161021.7997ad9d.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 June 2004 16:10:21 -0700, Andrew Morton wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> >
> > read_page_state doesn't exist in 2.6.7-rc3 or 2.6.6-mm5.  How is it
> > defined?
> 
> It was in 2.6.7-rc3-mm1.

A beauty!  Your trick about submitting an ugly patch and waiting for
others to do something better really works. :)

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra
