Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268123AbTGIKVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268151AbTGIKVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:21:10 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:12431 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S268123AbTGIKSh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:18:37 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: John Kim <jak@easystreet.com>, linux-kernel@vger.kernel.org
Subject: Re: Oops error on scp
Date: Wed, 9 Jul 2003 12:33:09 +0200
User-Agent: KMail/1.5.1
References: <200307082036.34476.jak@easystreet.com>
In-Reply-To: <200307082036.34476.jak@easystreet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200307091233.09254.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Every time I have recreated the error, the mesg:
> "Unable to handle kernel NULL pointer dereference at virtual address
> 00000200" has appeared (the only variance being that the virtual address
> changes from 00000200 to 00000202 when I tried to scp over a different
> dir).  The oops error comes out when I have scp'ied maybe about 3 or 4 GBs,
> but this is not always the case.  I have tried changing filesystems
> (Reiserfs, ext2, ext3) to no avail, and I have run diags on my hard drive. 
> I am starting to question if there is a hardware failure in the RAM??

Thats what I would guess.

> I don't know--I've never seen/dealt with an oops error before.
>
> Please advise!

www.memtest86.com

Just run a full test (all tests enabled.


Regards,	
	Bernd

-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
