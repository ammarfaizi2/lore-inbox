Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261643AbSIXKus>; Tue, 24 Sep 2002 06:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSIXKus>; Tue, 24 Sep 2002 06:50:48 -0400
Received: from [198.149.18.6] ([198.149.18.6]:49040 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261643AbSIXKur>;
	Tue, 24 Sep 2002 06:50:47 -0400
Date: Tue, 24 Sep 2002 14:10:41 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020924141041.A989@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
References: <F425930C-CF2E-11D6-8873-00039387C942@mac.com> <Pine.LNX.4.44.0209232233250.2343-100000@localhost.localdomain> <20020923185756.C13340@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020923185756.C13340@hexapodia.org>; from adi@hexapodia.org on Mon, Sep 23, 2002 at 06:57:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another advantage of keeping a "process" concept is that things like CSA
> (Compatible System Accounting, nee Cray System Accounting)

Which has been ported to Linux now, btw (rather poorly integrated, though):

	http://oss.sgi.com/projects/csa/
