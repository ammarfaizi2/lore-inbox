Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTIIRTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264338AbTIIRTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:19:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:26515 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264337AbTIIRTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:19:22 -0400
Date: Tue, 9 Sep 2003 10:19:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS update
In-Reply-To: <15065.1063117634@redhat.com>
Message-ID: <Pine.LNX.4.44.0309091018440.28373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Sep 2003, David Howells wrote:
> 
> Here's a patch to update my AFS filesystem driver. It is mostly miscellaneous
> fixes and typedef removal.

Can you send a more recent version that test3? I got 5 rejects, and I'd 
rather have you sort it out than me ;)

		Linus

