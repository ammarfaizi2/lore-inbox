Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265652AbUFDGti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265652AbUFDGti (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 02:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUFDGtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 02:49:36 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:53812 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265652AbUFDGtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 02:49:35 -0400
Date: Thu, 3 Jun 2004 23:57:33 -0700
From: Paul Jackson <pj@sgi.com>
To: "David S. Miller" <davem@redhat.com>
Cc: nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603235733.05eb2955.pj@sgi.com>
In-Reply-To: <20040603222209.27166d0f.davem@redhat.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<20040603222209.27166d0f.davem@redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Miller wrote:
> I would suggest just making the build fail for these cases.

Interesting suggestion.

Others with more experience in such matters will have to
comment on whether it's a good idea.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
