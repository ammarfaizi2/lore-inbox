Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317673AbSHQLjm>; Sat, 17 Aug 2002 07:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317695AbSHQLjm>; Sat, 17 Aug 2002 07:39:42 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:35846 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S317673AbSHQLjl>;
	Sat, 17 Aug 2002 07:39:41 -0400
Date: Sat, 17 Aug 2002 12:43:29 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre3
In-Reply-To: <Pine.LNX.4.44.0208162231060.8044-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0208171240190.7887-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last attempt at documentation patches again against 2.4.20pre3 .

http://www.csn.ul.ie/~mel/projects/vm/patches/2.4.20pre3/2.4.20pre3_documentation_numa
http://www.csn.ul.ie/~mel/projects/vm/patches/2.4.20pre3/2.4.20pre3_page_alloc_commentry
http://www.csn.ul.ie/~mel/projects/vm/patches/2.4.20pre3/2.4.20pre3_paging_documentation
http://www.csn.ul.ie/~mel/projects/vm/patches/2.4.20pre3/2.4.20pre3_slab_commentry
http://www.csn.ul.ie/~mel/projects/vm/patches/2.4.20pre3/2.4.20pre3_vmalloc_commentry

All of them but page_alloc is the same as the pre2 ones and it applied
cleanly with offsets.

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel

