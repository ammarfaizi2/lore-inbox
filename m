Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTFYH2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 03:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTFYH2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 03:28:31 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:27529 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262945AbTFYH2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 03:28:30 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21: kernel BUG at ide-iops.c:1262!
Mail-Copies-To: never
References: <1056493150.2840.17.camel@ori.thedillows.org>
	<20030624204828.I30001@newbox.localdomain>
From: Roland Mas <roland.mas@free.fr>
Date: Wed, 25 Jun 2003 09:42:38 +0200
In-Reply-To: <20030624204828.I30001@newbox.localdomain> (Scott McDermott's
 message of "Tue, 24 Jun 2003 20:48:28 -0400")
Message-ID: <87vfuuvc0h.fsf@free.fr>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott McDermott, 2003-06-24 20:48:28 -0400 :

> There were recent threads about this, and a Bugzilla bug 829 I
> think.  Try killing magicdev.

Okay, I'll ask a LKML-newbie question.  Bugzilla says "Linux 2.5
kernel bugs only at this time"...  Does that mean this bug won't be
fixed in 2.4, or just that the fix will be written for 2.5 and then
backported to 2.4?

Roland.
-- 
Roland Mas

Au royaume des aveugles, les borgnes n'ont qu'un oeil.
