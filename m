Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSEVPyB>; Wed, 22 May 2002 11:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316214AbSEVPyA>; Wed, 22 May 2002 11:54:00 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:49586 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S316213AbSEVPyA>; Wed, 22 May 2002 11:54:00 -0400
Date: Wed, 22 May 2002 08:53:28 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>
cc: linux-kernel@vger.kernel.org, andrea@suse.de, riel@surriel.com,
        torvalds@transmeta.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <1403955762.1022057606@[10.10.2.3]>
In-Reply-To: <1403412981.1022057064@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wouldn't bother using RedHat's kernel for this at the moment, 
> Andrea's tree is where the development work for this area has all
> been happening recently. He's working on integrating O(1) sched
> right now, which will get rid of the biggest issue I have with -aa
> at the moment (the issue being that I'm too idle^H^H^H^Hbusy to
> merge it ;-)).

Oh, of course, I left of the bounce buffer issue, which RedHat *have*
fixed in their tree, I believe. Not sure what the status of this work
is for -aa at the moment.

M.

