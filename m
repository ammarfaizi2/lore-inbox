Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261749AbSJMWHI>; Sun, 13 Oct 2002 18:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261751AbSJMWHI>; Sun, 13 Oct 2002 18:07:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63492 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261749AbSJMWHI>; Sun, 13 Oct 2002 18:07:08 -0400
Date: Sun, 13 Oct 2002 15:15:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Summit support for 2.5 [0/4]
In-Reply-To: <48100000.1034543175@flay>
Message-ID: <Pine.LNX.4.44.0210131514240.1775-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 Oct 2002, Martin J. Bligh wrote:
> 1. Time
> 2. It'd make the patches much bigger and harder to read.

Hmm.. I'd actually rather have the code split up in the proper location,
even if it would mean that summit support wouldn't work (or even
necessarily compile) by the feature-freeze.

		Linus

