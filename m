Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTJIItf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 04:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTJIItf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 04:49:35 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:61427 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id S261930AbTJIIte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 04:49:34 -0400
Date: Thu, 09 Oct 2003 10:49:18 +0200
From: Domen Puncer <domen@coderock.org>
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
In-reply-to: <Pine.LNX.4.53.0310082152380.21753@montezuma.fsmlabs.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <200310091049.18595.domen@coderock.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.4
References: <200310061529.56959.domen@coderock.org>
 <200310081705.16241.domen@coderock.org>
 <Pine.LNX.4.53.0310082152380.21753@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 of October 2003 03:53, Zwane Mwaikambo wrote:
> On Wed, 8 Oct 2003, Domen Puncer wrote:
> > Ok, updated to the one that ships with redhat.
> > Now i get:
> > eth0: link ok
> > when it is slow (-test2 module)
> >
> > and:
> > eth0: negotiated 100baseTx-FD, link ok
> > when it is ok (reloaded -test2 module)
>
> What does mii-tool -r do?

Doesn't help, neither do -R or -F.

