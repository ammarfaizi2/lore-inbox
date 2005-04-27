Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVD0Xlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVD0Xlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 19:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVD0Xly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 19:41:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:43959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262062AbVD0Xlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 19:41:53 -0400
Date: Wed, 27 Apr 2005 16:40:56 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-Id: <20050427164056.0598572d.rddunlap@osdl.org>
In-Reply-To: <20050427140342.GG10685@puettmann.net>
References: <20050427140342.GG10685@puettmann.net>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005 16:03:42 +0200 Ruben Puettmann wrote:

|                 hy,
| 
| 
| I'm trying to install linux on an HP DL385 but directly on boot I got
| this kernel panic:
| 
|         http://www.puettmann.net/temp/panic.jpg
| 
| Config attached.

I booted that .config (with a couple of SCSI & SATA device changes)
with no problem on a dual-proc Opteron machine (not HP DL385).

What compiler are you using?  (gcc --version)

---
~Randy
