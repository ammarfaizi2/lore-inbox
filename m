Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTJRRVh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTJRRVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:21:37 -0400
Received: from mcomail04.maxtor.com ([134.6.76.13]:16401 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S261731AbTJRRVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:21:35 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB2EF@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Nuno Silva'" <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org
Subject: RE: Blockbusting news, this is important (Re: Why are bad disk se
	ctors numbered strangely, and what happens to them?)
Date: Sat, 18 Oct 2003 11:18:52 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Nuno Silva [mailto:nuno.silva@vgertech.com]
>
> > 
> > Doing cat /dev/zero > /dev/hd* fixes all bad sectors on 
> modern drive.
> 
> Yeah! I'm doing this right now because the data in hda is 
> very important 
> and and don't do backups since August!! :-D

If current trends hold, in the next few years, hard drives are going to have
to pick up and rewrite their data continuously to avoid signal decay on the
media... a drive gets closer and closer to a DRAM cell than a stone tablet.
(And yes, I've heard all the jokes about bricks/stones/etc)
