Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTEJQUf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264438AbTEJQUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:20:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28304
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264437AbTEJQUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:20:34 -0400
Subject: Re: The disappearing sys_call_table export.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305091707.h49H75b9008938@turing-police.cc.vt.edu>
References: <200305090352_MC3-1-3815-126F@compuserve.com>
	 <1052482717.14539.10.camel@dhcp22.swansea.linux.org.uk>
	 <200305091707.h49H75b9008938@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052580886.16165.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 May 2003 16:34:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-09 at 18:07, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 09 May 2003 13:18:38 BST, Alan Cox said:
> 
> > What makes you say that. If the administrator has full priviledges then
> > its kind of irrelevant trying to force anything "for security reasons"
> 
> Many security models require that there *not* be one person who has "full"
> privileges (for obvious reasons).

And SELInux already lets you enforce such a policy

