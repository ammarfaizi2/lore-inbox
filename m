Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267025AbTAKBZG>; Fri, 10 Jan 2003 20:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbTAKBZG>; Fri, 10 Jan 2003 20:25:06 -0500
Received: from havoc.daloft.com ([64.213.145.173]:37078 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267025AbTAKBZF>;
	Fri, 10 Jan 2003 20:25:05 -0500
Date: Fri, 10 Jan 2003 20:33:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: jjs <jjs@lexus.com>
Cc: Marc-Christian Petersen <m.c.p@gmx.net>, Bill Abt <babt@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NGPT 2.2.0 RELEASED: TOPS LINUXTHREADS AND NPTL IN SCALABILITY AND PERFORMANCE
Message-ID: <20030111013346.GB25649@gtf.org>
References: <OFD6D876A7.7D7E3A46-ON85256CAA.0068C7D5@us.ibm.com> <200301110203.09346.m.c.p@gmx.net> <3E1F72D7.7050505@lexus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1F72D7.7050505@lexus.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 05:26:47PM -0800, jjs wrote:
> But according to my understanding, a more accurate
> measure of nptl performance would require a current
> glibc, with the nptl-specific enhancements -
> 
> or am I missing something here?

You are correct:  you need a recent 2.5 kernel and a recent glibc.


