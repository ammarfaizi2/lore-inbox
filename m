Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265430AbSJSA4U>; Fri, 18 Oct 2002 20:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265432AbSJSA4U>; Fri, 18 Oct 2002 20:56:20 -0400
Received: from sj-msg-core-4.cisco.com ([171.71.163.54]:34738 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S265430AbSJSA4T>; Fri, 18 Oct 2002 20:56:19 -0400
Date: Fri, 18 Oct 2002 18:02:04 -0700 (PDT)
From: Brad Bozarth <prettygood@cs.stanford.edu>
X-X-Sender: bbozarth@bbozarth-lnx.cisco.com
Reply-To: prettygood@cs.stanford.edu
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
Message-ID: <Pine.LNX.4.44.0210181754330.2223-100000@bbozarth-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to add my vote to including George's high-res patches in 
2.5...  The advantages have been expounded by others, along with their few 
downsides (compared to just bumping up HZ).  Especially for embedded 
systems, but in general also, these make sense..  I'm nearly done with an 
initial mips implementation, which we'll be using in my group at Cisco.

Thanks,
Brad

