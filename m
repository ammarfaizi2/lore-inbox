Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTEONyR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 09:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbTEONyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 09:54:17 -0400
Received: from relay2.av8.net ([130.105.12.4]:19218 "EHLO citation.av8.net")
	by vger.kernel.org with ESMTP id S264022AbTEONyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 09:54:15 -0400
Date: Thu, 15 May 2003 10:04:40 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
X-X-Sender: dean@commander.av8.net
To: Linus Torvalds <torvalds@transmeta.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Garance A Drosihn <drosih@rpi.edu>, Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
In-Reply-To: <Pine.LNX.4.44.0305141904340.28093-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0305150957210.4983-100000@commander.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pardon me if I'm wrong, but doesn't the PAG already allow for multiple
credentials?  Linus seems to be arguing for multiple PAGs, like multiple
GIDs. But I think that functionality is really there, inside the PAG. It
seems to me (somewhat) that there is really violent agreement, but varying
terms.

		--Dean



