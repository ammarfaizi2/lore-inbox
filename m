Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSHaAdP>; Fri, 30 Aug 2002 20:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSHaAdP>; Fri, 30 Aug 2002 20:33:15 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:50416
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315374AbSHaAdO>; Fri, 30 Aug 2002 20:33:14 -0400
Subject: Re: lockup on Athlon systems, kernel race condition?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3D6FE062.A48B6F03@zip.com.au>
References: <20020830204022.GC736@hygelac>  <3D6FE062.A48B6F03@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 31 Aug 2002 01:36:55 +0100
Message-Id: <1030754215.1232.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicate the problem without NVdriver having ever been loaded that
boot, then it might be interesting

