Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSHOBcE>; Wed, 14 Aug 2002 21:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319321AbSHOBcE>; Wed, 14 Aug 2002 21:32:04 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:54778 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316586AbSHOBcE>; Wed, 14 Aug 2002 21:32:04 -0400
Subject: Re: [OOPS] 2.4.20-pre1-ac3, SMP (Dual PIII)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
Cc: Antti Salmela <asalmela@iki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20020814173057.18028.qmail@thales.mathematik.uni-ulm.de>
References: <20020814145454.A21254@wasala.fi>
	<1029328630.26226.21.camel@irongate.swansea.linux.org.uk>
	<20020814161037.A22388@wasala.fi>
	<1029331629.26227.36.camel@irongate.swansea.linux.org.uk>
	<20020814185505.A23923@wasala.fi> 
	<20020814173057.18028.qmail@thales.mathematik.uni-ulm.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 02:33:02 +0100
Message-Id: <1029375182.28236.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks - your analysis is informative to say the least. It looks like
the PIV load balancing code is the problem. 

