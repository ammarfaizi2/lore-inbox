Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUDPMkS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 08:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUDPMkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 08:40:18 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:9220 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263159AbUDPMkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 08:40:12 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: SATA support merge in 2.4.27
Date: Fri, 16 Apr 2004 14:39:15 +0200
User-Agent: KMail/1.6.1
Cc: John Bradford <john@grabjohn.com>, Arjan van de Ven <arjanv@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <Pine.LNX.4.10.10404160259480.22035-100000@master.linux-ide.org> <20040416102820.GD14796@devserv.devel.redhat.com> <200404161237.i3GCb9Jf000164@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200404161237.i3GCb9Jf000164@81-2-122-30.bradfords.org.uk>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404161439.15102@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 April 2004 14:37, John Bradford wrote:

Hi,

> > > A valid point, but last time I checked, there were known exploits that
> > > had been fixed in 2.4 but not in 2.6.
> > maybe you should check again and report what you find because I for sure
> > can't think of any.

> I honestly don't have the time to go through the archives at the moment,
> and having been busy, I could well have missed any fixes that have gone in
> during the last couple of releases, but I am 99% sure that Alan identified
> a couple of local root exploits around 2.6.0 that had been fixed in 2.4 but
> never applied to 2.6.

well, last time I checked that (some weeks ago), also reading must-fix.txt, 
all 2.4 security fixes are in 2.6 now too. IMHO we should update must-fix.txt 
so it does not tell there are 60-70 security vulns not fixed yet.

ciao, Marc
