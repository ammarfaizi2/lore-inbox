Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266191AbUAQWGn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 17:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUAQWGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 17:06:43 -0500
Received: from mail.webmaster.com ([216.152.64.131]:64972 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S266191AbUAQWGm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 17:06:42 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Misshielle Wong" <mwl@bajoo.net>, "Giuliano Pochini" <pochini@shiny.it>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: License question
Date: Sat, 17 Jan 2004 14:06:32 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEPBJJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
In-Reply-To: <opr1xqbz2lq5eh14@localhost>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > Is it possile to include in the kernel distro some code with this
> > BSD-style license ?

> Let me see

	Yes, in general. No, not this license.
 
> > - Redistributions of source code must retain the above copyright
> > notice, this list of conditions and the following disclaimers.

	Sorry, that's an "additional restriction" not permitted under the GPL.

> > - Redistributions in binary form must reproduce the above copyright
> > notice, this list of conditions and the following disclaimers in the
> > documentation and/or other materials provided with the distribution.

	I believe this is an additional restriction as well.

> Mmmm... I think yes. Code in kernel must be licensed GPL. Above allow 
> sublicense so ok

	They allow sublicensing, but the sublicense can't remove the additional restriction. See section 6 of the GPL.

	To make this license GPL compatible, the two restrictions above would have to be modified to be identical to, or a proper subset of, section 2 clauses b and c of the GPL.

	DS


