Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318495AbSGSJ2p>; Fri, 19 Jul 2002 05:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318496AbSGSJ2p>; Fri, 19 Jul 2002 05:28:45 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:7434 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318495AbSGSJ2o>; Fri, 19 Jul 2002 05:28:44 -0400
Date: Fri, 19 Jul 2002 11:31:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new module format
In-Reply-To: <20020719184211.4440e6cb.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0207191128030.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 19 Jul 2002, Rusty Russell wrote:

> 	I've started updating my in-kernel module loader patches for 2.5.26.
> I'll send you a mail when it's done.

The more I think about it, the more I like the idea to go into the other
direction. Most of the module information (e.g. symbols, dependencies)
stored in the kernel can be as well managed in userspace.

bye, Roman

