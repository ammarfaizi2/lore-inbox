Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262745AbRE3MDg>; Wed, 30 May 2001 08:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262746AbRE3MD0>; Wed, 30 May 2001 08:03:26 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:26374 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262745AbRE3MDX>;
	Wed, 30 May 2001 08:03:23 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: ankry@green.mif.pg.gda.pl
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net #3 
In-Reply-To: Your message of "Wed, 30 May 2001 12:53:36 +0200."
             <200105301053.MAA02686@sunrise.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 May 2001 22:03:17 +1000
Message-ID: <19457.991224197@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001 12:53:36 +0200 (MET DST), 
Andrzej Krzysztofowicz <ankry@pg.gda.pl> wrote:
>When __init for modules will be implemented ?

When I can persuade myself that discarding code pages but retaining the
associated exception tables and any arch dependent data for the
discarded module pages is safe.  Definitely 2.5 material anyway.

