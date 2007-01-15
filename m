Return-Path: <linux-kernel-owner+w=401wt.eu-S932258AbXAOMGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbXAOMGl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 07:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbXAOMGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 07:06:41 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57116 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932258AbXAOMGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 07:06:40 -0500
Message-Id: <200701150211.l0F2BDgI015824@laptop13.inf.utfsm.cl>
To: florin@iucha.net (Florin Iucha)
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jiri Kosina <jikos@jikos.cz>, linux-usb-devel@lists.sourceforge.net,
       Adrian Bunk <bunk@stusta.de>, Alan Stern <stern@rowland.harvard.edu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: heavy nfs[4]] causes fs badness Was: 2.6.20-rc4: known unfixed regressions (v2) 
In-Reply-To: Message from florin@iucha.net (Florin Iucha) 
   of "Sun, 14 Jan 2007 17:58:17 MDT." <20070114235816.GB6053@iucha.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Sun, 14 Jan 2007 23:11:13 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 15 Jan 2007 09:03:36 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florin Iucha <florin@iucha.net> wrote:

[...]

> Based on this info, I think we can rule out any USB.  I will try
> testing with NFS3 to see if the problem persists.  Unfortunately there
> is no oops or anything in "dmesg".

Take a look at bz #7796, a NFS bug + fix. But my feelin is that this is
older.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
