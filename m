Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262147AbTCHTbK>; Sat, 8 Mar 2003 14:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262149AbTCHTbK>; Sat, 8 Mar 2003 14:31:10 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:28942 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262147AbTCHTbJ>;
	Sat, 8 Mar 2003 14:31:09 -0500
Date: Sat, 8 Mar 2003 11:31:37 -0800
From: Greg KH <greg@kroah.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       cherry@osdl.org, rddunlap@osdl.org, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308193137.GC26374@kroah.com>
References: <20030307225517.GF2835@ca-server1.us.oracle.com> <20030307225710.A18005@infradead.org> <20030307151744.73738fdd.rddunlap@osdl.org> <1047080297.10926.180.camel@cherrytest.pdx.osdl.net> <20030307233636.A19260@infradead.org> <20030307154624.12105fa3.akpm@digeo.com> <20030307235454.A19662@infradead.org> <20030308014911.GG2835@ca-server1.us.oracle.com> <20030308015805.GA23591@kroah.com> <20030308021505.GH2835@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308021505.GH2835@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 06:15:05PM -0800, Joel Becker wrote:
> 
> 	I personally think that /dev population should exist in
> userspace as well.  I *hope* you mean to populate a regular filesystem
> with device nodes that your system manages.

Yes, a ramfs partition is the original target.

thanks,

greg k-h
