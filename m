Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbSLDQ4q>; Wed, 4 Dec 2002 11:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbSLDQ4q>; Wed, 4 Dec 2002 11:56:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43023 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266977AbSLDQ4p>; Wed, 4 Dec 2002 11:56:45 -0500
Date: Wed, 4 Dec 2002 09:05:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: sfr@canb.auug.org.au, <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       <ak@muc.de>, <davidm@hpl.hp.com>, <schwidefsky@de.ibm.com>,
       <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <20021204.085418.12053463.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0212040903170.1990-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Dec 2002, David S. Miller wrote:
> 
> "Just do it." :-)

Pushing the result out now (after having done a quick test that it would 
seem to work on x86 if it had a compat layer).

		Linus

