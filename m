Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266128AbSLISmZ>; Mon, 9 Dec 2002 13:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266120AbSLISmZ>; Mon, 9 Dec 2002 13:42:25 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:59300 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266128AbSLISmX> convert rfc822-to-8bit; Mon, 9 Dec 2002 13:42:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: ronis@onsager.chem.mcgill.ca, David Ronis <ronis@ronispc.chem.mcgill.ca>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: build failure in 2.4.20
Date: Mon, 9 Dec 2002 19:49:37 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, ronis@onsager.chem.mcgill.ca,
       David Ronis <ronis@ronispc.chem.mcgill.ca>
References: <15860.46389.654483.692231@ronispc.chem.mcgill.ca> <20021209173144.GA3751@suse.de> <15860.58665.606855.853566@ronispc.chem.mcgill.ca>
In-Reply-To: <15860.58665.606855.853566@ronispc.chem.mcgill.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212091949.37730.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 December 2002 19:47, David Ronis wrote:

Hi David,

> Dave, I haven't had a chance to look at the URL you suggested yet (and
> probably do not have the expertise to fix things the way you're
> suggesting either); is Marc-Christian's fix safe in the mean time?
It will bloat the kernel somewhat, but it's safe in the meantime. I cook up a 
patch with a _real_ fix :-)

ciao, Marc
