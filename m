Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbSLCSub>; Tue, 3 Dec 2002 13:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbSLCSub>; Tue, 3 Dec 2002 13:50:31 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:39585 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265423AbSLCSub>; Tue, 3 Dec 2002 13:50:31 -0500
Subject: RE: [BK PATCH] ACPI updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A56B@orsmsx119.jf.intel.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A56B@orsmsx119.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Dec 2002 19:31:55 +0000
Message-Id: <1038943915.11437.85.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 18:39, Grover, Andrew wrote:
> Is your concern with the code, or the cmdline option? We could certainly
> keep the same cmdline option "acpismp=force" if that is the issue, but that
> always seemed like kind of a strange name for the option, to me.

strange or otherwise - changing it in 2.4 is a bad idea - keeping it as
well as the 2.5 option is safer. 2.4 should continue to work on upgrades
as people expected it to - conservatism is the key. I think thats why
Arjan is arguing as he does

