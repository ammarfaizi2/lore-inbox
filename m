Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265486AbTGLMwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 08:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbTGLMwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 08:52:16 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:52960
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S265486AbTGLMwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 08:52:15 -0400
Date: Sat, 12 Jul 2003 15:07:39 +0200
From: Voluspa <lista1@telia.com>
To: ivg2@cornell.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 does not boot - TCQ oops
Message-Id: <20030712150739.6f1d9700.lista1@telia.com>
In-Reply-To: <200307120646.01060.ivg2@cornell.edu>
References: <200307120646.01060.ivg2@cornell.edu>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 12 Jul 2003 06:46:01 -0400
Ivan Gyurdiev <ivg2@cornell.edu> wrote:

[...]
> However, the kernel that crashed was using the default
> (The default is 8, even though the comment says 32).

Some nice testing you've done there. Yeah, the 'map vs reality' is
confusing when configuring. I previously changed the 8 to 32, following
the help, but for 2.5.75 changed it to 8 based on an offhand comment on
lkml saying: '8 has been tested as optimal'.

Hope LinuxTag isn't drawing all the developers attention away from your
problem!

Mvh
Mats Johannesson
