Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272270AbTG3VLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272271AbTG3VLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:11:42 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:49433 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S272270AbTG3VLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:11:41 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200307302111.h6ULBci06803@devserv.devel.redhat.com>
Subject: Re: Warn about taskfile?
To: pavel@ucw.cz (Pavel Machek)
Date: Wed, 30 Jul 2003 17:11:38 -0400 (EDT)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20030730205935.GA238@elf.ucw.cz> from "Pavel Machek" at Gor 30, 2003 10:59:35 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had some strange fs corruption, and andi suggested that it probably
> is TASKFILE-related. Perhaps this is good idea?

Well without taskfile multimode may corrupt your disks, so pick one.
This needs debugging not paranoia.

> +	  It is safe to say Y to this question, but you should attach
> +	  scratch monkey, first.

"a scratch monkey" - also a lot of people won't get the reference

