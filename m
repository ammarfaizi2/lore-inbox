Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVGZFY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVGZFY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVGZFYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:24:25 -0400
Received: from dial169-98.awalnet.net ([213.184.169.98]:47113 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S261728AbVGZFX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:23:29 -0400
Message-Id: <200507260524.IAA06931@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Horst von Brand'" <vonbrand@inf.utfsm.cl>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel optimization 
Date: Tue, 26 Jul 2005 08:22:59 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200507231849.j6NInMPO003728@laptop11.inf.utfsm.cl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcWRj7OhnGffmV4/TkSTCV90OCCInAACm3qg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. Horst H. von Brand wrote: {
Al Boldi <a1426z@gawab.com> wrote:
>  Adrian Bunk wrote: {
> On Fri, Jul 22, 2005 at 07:55:48PM +0100, christos gentsis wrote:
> > i would like to ask if it possible to change the optimization of the 
> > kernel from -O2 to -O3 :D, how can i do that? if i change it to the 
> > top level Makefile does it change to all the Makefiles?
> And since it's larger, it's also slower.
> }

> It's faster but it's flawed.  Root-NFS boot failed!

How do you know that it is faster if it is busted?
}

The -O3 compile produces a faster kernel, which seems to work perfectly,
albeit the Root-NFS boot flaw!

--
Al

