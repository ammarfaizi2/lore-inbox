Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbSJVStG>; Tue, 22 Oct 2002 14:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264935AbSJVStG>; Tue, 22 Oct 2002 14:49:06 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:26862 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264934AbSJVStD>; Tue, 22 Oct 2002 14:49:03 -0400
Date: Tue, 22 Oct 2002 14:55:10 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <20021022145510.H20957@redhat.com>
References: <1035310934.31917.124.camel@irongate.swansea.linux.org.uk> <E184442-0001zQ-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E184442-0001zQ-00@w-gerrit2>; from gh@us.ibm.com on Tue, Oct 22, 2002 at 11:47:37AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 11:47:37AM -0700, Gerrit Huizenga wrote:
> Hmm.  Isn't it great that 2.6/3.0 will be stable soon and we can
> start working on this for 2.7/3.1?

Sure, but we should delete the syscalls now and just use the filesystem 
as the intermediate API.

		-ben
-- 
"Do you seek knowledge in time travel?"
