Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbSL3APg>; Sun, 29 Dec 2002 19:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbSL3APf>; Sun, 29 Dec 2002 19:15:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11904
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264766AbSL3APe>; Sun, 29 Dec 2002 19:15:34 -0500
Subject: Re: holy grail
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Anomalous Force <anomalous_force@yahoo.com>,
       Werner Almesberger <wa@almesberger.net>, ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50L.0212281842020.26879-100000@imladris.surriel.com>
References: <20021228163517.66372.qmail@web13207.mail.yahoo.com> 
	<Pine.LNX.4.50L.0212281842020.26879-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 01:05:04 +0000
Message-Id: <1041210304.1172.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-28 at 20:43, Rik van Riel wrote:
> Either they're still working on the problem (after a four
> years) or they've moved on to an easier/realistic project.

Or they read a book on clusters and figured it out

Roughly speaking

If you care about uptime to the point of live kernel updates
        Additional systems are acceptable costs
        Hardware failure is also unacceptable
        Clustering is cheaper than solving the kernel on the fly problem

