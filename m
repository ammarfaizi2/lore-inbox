Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWDQVJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWDQVJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 17:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWDQVJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 17:09:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6596 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751294AbWDQVJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 17:09:50 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit
	from 8TB to 16TB
From: Arjan van de Ven <arjan@infradead.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Laurent Vivier <Laurent.Vivier@bull.net>, Andrew Morton <akpm@osdl.org>,
       Mingming Cao <cmm@us.ibm.com>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060417210746.GB3945@localhost.localdomain>
References: <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329175446.67149f32.akpm@osdl.org>
	 <1144660270.5816.3.camel@openx2.frec.bull.fr>
	 <20060410012431.716d1000.akpm@osdl.org>
	 <1144941999.2914.1.camel@openx2.frec.bull.fr>
	 <20060417210746.GB3945@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 23:09:36 +0200
Message-Id: <1145308176.2847.90.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 14:07 -0700, Ravikiran G Thirumalai wrote:
> 
> 
> I ran the same tests on a 16 core EM64T box very similar to the one
> you ran
> dbench on :). Dbench results on ext3 varies quite a bit.  I couldn't
> get 
> to a statistically significant conclusion  For eg,


dbench is not a good performance benchmark. At all. Don't use it for
that ;)


