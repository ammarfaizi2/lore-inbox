Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271710AbTHDMZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 08:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271712AbTHDMZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 08:25:26 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:17171 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S271710AbTHDMZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 08:25:26 -0400
Message-Id: <200308041215.h74CFLj12258@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Heikki Tuuri" <Heikki.Tuuri@innodb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm3 and mysql
Date: Mon, 4 Aug 2003 15:24:52 +0300
X-Mailer: KMail [version 1.3.2]
References: <009201c3599f$04ff05c0$322bde50@koticompaq> <20030803022723.760f6451.akpm@osdl.org> <00b901c359ac$0c7fe0a0$322bde50@koticompaq>
In-Reply-To: <00b901c359ac$0c7fe0a0$322bde50@koticompaq>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 August 2003 13:43, Heikki Tuuri wrote:
> > Well there's a problem.  We're kernel people, not database people.  I, for
> > one, would not have a clue how to set such a thing up.
> >
> > If someone could prepare a simple-enough-for-kernel-people description of
> > how to get such a test up and running, then we might make some progress.
> 
> ok :).
> 
> 1. Download

[4 screenfuls snipped]

That's a hell of a setup work, and kernel folks will always get slightly
different setups. Can database folks make a fully configured chrootable
tarball for mysql stress testing?
--
vda
