Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbULNUkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbULNUkE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbULNUkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:40:03 -0500
Received: from main.gmane.org ([80.91.229.2]:57537 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261653AbULNUj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:39:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9 (with changes)
Date: Tue, 14 Dec 2004 15:39:53 -0500
Message-ID: <874qiolili.fsf@coraid.com>
References: <87k6rmuqu4.fsf@coraid.com> <20041213212301.GI16958@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-230-221.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:i6NZyvCH37GIQZgyGazCNGbYdik=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

> On Mon, 2004-12-13 11:04:51 -0500, Ed L Cashin <ecashin@coraid.com>
> wrote in message <87k6rmuqu4.fsf@coraid.com>:
> [...]
>
> Impressive list of changes. I'm thinking about implementing a userland
> server for AoE. Is there a formal protocol specification available?

Yes.  It's here:

  http://www.coraid.com/documents/AoEr8.txt
  http://www.coraid.com/documents/AoEr8.pdf

> Though, I'd use the block driver's sources to reverse engineer it, but
> for interoperability purposes, it would probably be better to start off
> a specification than an implementation.
>
> . o O (...and I'd love to get my hands on a real hardware device)

There are some eval kits that can be ordered on our web site.

-- 
  Ed L Cashin <ecashin@coraid.com>

