Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262372AbSJVJ33>; Tue, 22 Oct 2002 05:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbSJVJ32>; Tue, 22 Oct 2002 05:29:28 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:47031 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262372AbSJVJ32>; Tue, 22 Oct 2002 05:29:28 -0400
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: thockin@sun.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210220036.g9M0aP831358@scl2.sfbay.sun.com>
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 10:51:34 +0100
Message-Id: <1035280294.31917.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok sanity check time. Why do you need qsort and bsearch for this kind of
thing. Just how many groups do you plan to support ?

