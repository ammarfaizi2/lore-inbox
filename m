Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313412AbSDPABt>; Mon, 15 Apr 2002 20:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313413AbSDPABs>; Mon, 15 Apr 2002 20:01:48 -0400
Received: from pool-151-201-224-154.pitt.east.verizon.net ([151.201.224.154]:11649
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id <S313412AbSDPABr>; Mon, 15 Apr 2002 20:01:47 -0400
Date: Mon, 15 Apr 2002 20:01:43 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: link() security
Message-ID: <20020415200143.E431@marta>
In-Reply-To: <E16xFtQ-0007Gp-00@the-village.bc.nu> <3CBB5ECB.2040002@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scribbling feverishly on April 15, H. Peter Anvin managed to emit:

[schnip]

> The point was mostly that storing mail in a (basically) unstructured
> flat-file format isn't really consistent with the operations you want to
> perform on it.  I didn't mean the directory/file format was necessarily
> the ultimate solution, only that (a) it works better than mbox, (b) it's
> been around for a long time.

[nod] 

I suppose it made sense back when we made our 1s and 0s by hand, but
whoever (would dare) take credit for "designing" the UNIX mbox "format"
needs a remedial course if file format design.

K
-- 
Are you ever going to do the dishes?  Or will you change your major to biology?
