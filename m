Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbTCLPca>; Wed, 12 Mar 2003 10:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261655AbTCLPca>; Wed, 12 Mar 2003 10:32:30 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:35406 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261605AbTCLPc3>; Wed, 12 Mar 2003 10:32:29 -0500
Date: Wed, 12 Mar 2003 15:43:11 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Message-ID: <20030312154311.H32093@devserv.devel.redhat.com>
References: <1047464392.1556.4.camel@laptop.fenrus.com> <Pine.LNX.4.30.0303121629120.18304-100000@divine.city.tvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.30.0303121629120.18304-100000@divine.city.tvnet.hu>; from szaka@sienet.hu on Wed, Mar 12, 2003 at 04:35:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 04:35:10PM +0100, Szakacsits Szabolcs wrote:
> If all vendors is Red Hat then I believe you. 

I say All Vendors simply because no vendor ships 2.5 kernels yet which
have the CONFIG option to NOT use -fomit-frame-pointer
