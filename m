Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264796AbTLLNxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTLLNwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:52:47 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:4233 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S264578AbTLLNwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:52:45 -0500
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
From: Vladimir Saveliev <vs@namesys.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031212134301.GD6112@wohnheim.fh-wedel.de>
References: <20031211125806.B2422@hexapodia.org>
	 <017c01c3c01b$232bd130$d43147ab@amer.cisco.com>
	 <20031211194815.GA10029@wohnheim.fh-wedel.de>
	 <200312111432.12683.rob@landley.net>
	 <20031212125513.GC6112@wohnheim.fh-wedel.de>
	 <1071235698.27730.146.camel@tribesman.namesys.com>
	 <20031212134301.GD6112@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1071237163.26354.154.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Dec 2003 16:52:43 +0300
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-12 at 16:43, Jörn Engel wrote:
> On Fri, 12 December 2003 16:28:18 +0300, Vladimir Saveliev wrote:
> > 
> > Sorry,
> > but doesn't truncate do almost exactly what "make hole" is supposed to
> > do?
> 
> Yeah, *almost* exactly.  Some people happen to care about the almost.
> 

I meant: where are those tons of problems (except for the fact that
"make hole" is obviously something without which one can live just
fine)? 

> Jörn

