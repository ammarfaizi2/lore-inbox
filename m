Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268155AbTBNAso>; Thu, 13 Feb 2003 19:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268156AbTBNAso>; Thu, 13 Feb 2003 19:48:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4230
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268155AbTBNAso>; Thu, 13 Feb 2003 19:48:44 -0500
Subject: RE: Question about 48 bit IDE on 2.4.18 kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry Hileman <LHileman@snapappliance.com>
Cc: Linux "Kernel \"Maillist " "(E-mail)" 
	<linux-kernel@vger.kernel.org>
In-Reply-To: <057889C7F1E5D61193620002A537E8690B5A2A@NCBDC>
References: <057889C7F1E5D61193620002A537E8690B5A2A@NCBDC>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045187955.15074.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Feb 2003 01:59:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-13 at 23:51, Larry Hileman wrote:
> Do the 2.4.20/21 predrivers work on a 2.4.18 kernel?
> Or have they been back ported?


No and no. The newer IDE code has dependancies on the block layer
improvements.

