Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSLFMeG>; Fri, 6 Dec 2002 07:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbSLFMeG>; Fri, 6 Dec 2002 07:34:06 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:16558 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262449AbSLFMeE>; Fri, 6 Dec 2002 07:34:04 -0500
Subject: Re: [TRIVIAL] Re: Kernel patches...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Trivial Russell <rusty@rustcorp.com.au>
Cc: linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021206035754.B2B912C256@lists.samba.org>
References: <20021206035754.B2B912C256@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 13:16:54 +0000
Message-Id: <1039180614.22971.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  OK, so here is the new patch.
  It takes advantage of hdXlun, so no changes to the config files are
needed.
  By default keeps IDE LUN at zero, unless hdXlun=n specified on command
line.
  Compiles with 2.4.20.
 

Rejected

