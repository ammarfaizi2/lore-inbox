Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSKYFSc>; Mon, 25 Nov 2002 00:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSKYFSc>; Mon, 25 Nov 2002 00:18:32 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:60432 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP
	id <S262420AbSKYFSb>; Mon, 25 Nov 2002 00:18:31 -0500
From: Tim Connors <tconnors@astro.swin.edu.au>
Message-Id: <200211250525.gAP5Pgx28358@hexane.ssi.swin.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-rc3
In-Reply-To: <Pine.LNX.4.44L.0211221520230.22247-100000@freak.distro.conectiva>
References: <Pine.LNX.4.44L.0211221520230.22247-100000@freak.distro.conectiva>
Date: Mon, 25 Nov 2002 16:25:42 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, you wrote:
> 
> Hi,
> 
> Finally, here goes -rc3.

Hmmm - problem compiling nfsd (v3) as a module. Compiles fine, but at
modprobe time, complains about missing symbol. If I remember
correctly, it was nfsd_linkage. Sorry, can't post the .config and a
more details report til tomorrow.


I noticed this problem quite a while ago - can't remember when it
started.


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

What's that crawling on my shoulder?
  Oh, it's my hair! -- Meagan

