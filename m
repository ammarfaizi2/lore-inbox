Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319631AbSH3Rmr>; Fri, 30 Aug 2002 13:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319632AbSH3Rmq>; Fri, 30 Aug 2002 13:42:46 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:4600 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319631AbSH3Rmq>;
	Fri, 30 Aug 2002 13:42:46 -0400
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, riel@surriel.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: statm_pgd_range() sucks! 
In-reply-to: Your message of Thu, 29 Aug 2002 20:12:08 PDT.
             <20020830031208.GK888@holomorphy.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21766.1030729534.1@us.ibm.com>
Date: Fri, 30 Aug 2002 10:45:35 -0700
Message-Id: <E17kppv-0005f8-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020830031208.GK888@holomorphy.com>, > : William Lee Irwin III wri
tes:
> I'm basically looking for VSZ, RSS, %cpu, & pid -- after that I don't
> care. top(1) examines a lot more than it feeds into the display, for
> reasons unknown. In principle, there are ways of recovering the other
> bits that seem too complex to be worthy of doing:

Try using "f" inside of top(1).  You'll see a set of additional
bits of info that it can report which may map to the data that it
examines but you haven't seen in its display.

gerrit
