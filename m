Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267714AbTBUVdW>; Fri, 21 Feb 2003 16:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267719AbTBUVdW>; Fri, 21 Feb 2003 16:33:22 -0500
Received: from cs78149057.pp.htv.fi ([62.78.149.57]:43441 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S267714AbTBUVdU>;
	Fri, 21 Feb 2003 16:33:20 -0500
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: John Bradford <john@grabjohn.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <200302212040.h1LKejY3001679@81-2-122-30.bradfords.org.uk>
References: <200302212040.h1LKejY3001679@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045863838.22625.121.camel@devil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 21 Feb 2003 23:43:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-21 at 22:40, John Bradford wrote:
> > Supporting this would make using ECN a lot less painful - currently, if
> > I want to use ECN by default, I get to turn it off anytime I find an
> > ECN-hostile site that I'd like to communicate with.
> 
> Linux shouldn't encourage the use of equipment that violates RFCs, in
> this case, RFC 739.
> 
> The correct way to deal with it, is to contact the maintainers of the
> site, and ask them to fix the non conforming equipment.

That's right. Unfortunately, the way most people *will* deal with it is
by turning ECN off permanently and forgetting about it. That won't help
ECN become widely adopted.

	MikaL

