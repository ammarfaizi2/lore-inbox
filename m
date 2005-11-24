Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVKXElr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVKXElr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 23:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVKXElq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 23:41:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51613 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751334AbVKXElp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 23:41:45 -0500
Date: Wed, 23 Nov 2005 20:40:12 -0800
From: Paul Jackson <pj@sgi.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com, mkrufky@linuxtv.org,
       bunk@stusta.de, js@linuxtv.org, sam@ravnborg.org, kirk.lapray@gmail.com
Subject: Re: Linux 2.6.15-rc2
Message-Id: <20051123204012.2b6457a9.pj@sgi.com>
In-Reply-To: <200511231736.58204.gene.heskett@verizon.net>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
	<4384D0EC.5050709@linuxtv.org>
	<Pine.LNX.4.61.0511232122300.13837@goblin.wat.veritas.com>
	<200511231736.58204.gene.heskett@verizon.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene wrote:
> I'm not familiar enough with git yet to try that without some hand
> holding :(

Git's bisect was announced in Linus's post:

  http://lkml.org/lkml/2005/7/30/106

Matt Mackall's mercurial (http://www.selenic.com/mercurial/) has a bisect
as well:

  http://www.selenic.com/pipermail/mercurial/2005-September/004697.html

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
