Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264131AbUFCST7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbUFCST7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 14:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbUFCST7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 14:19:59 -0400
Received: from adsl-67-118-43-14.dsl.renocs.pacbell.net ([67.118.43.14]:44675
	"EHLO mail.clouddancer.com") by vger.kernel.org with ESMTP
	id S264131AbUFCST5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 14:19:57 -0400
From: Klink <colonel@clouddancer.com>
To: WebMonster@idsa.ch
Cc: linux-kernel@vger.kernel.org
In-reply-to: <s0bf4d74.020@idfw.idsa.ch> (WebMonster@idsa.ch)
Subject: Re: .config question
Reply-To: colonel@clouddancer.com
References: <s0bf4d74.020@idfw.idsa.ch>
Message-Id: <20040603181956.A4B3A229E08@phoenix.clouddancer.com>
Date: Thu,  3 Jun 2004 11:19:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Date:	Thu, 03 Jun 2004 16:10:09 +0200
   From: "Francois Pernet" <WebMonster@idsa.ch>

   Hi,
   Sorry to not be part of the mailing list and ask question. Please,
   could you post any answer (CC) to this question, if relevant ? Many
   TIA.

Probably show up on the list, otherwise likely to be a silent fix RSN.
I was surprised that it hadn't been posted, spent time making sure
that I could repeat it....but it could still be something in my setup.


   I've got a kernel already installed in my machine (SuSe Pro 9). I would
   like to modify something and recompile the kernel. Since it has been
   installed from rpm, there is no .config in /usr/src/linux. Is there any
   way to create this file from the image and modules, so i do not need to
   verify all my config prior to change something ?

There is an option in 2.6 to determine the .config that built the
kernel somehow.  I've just noticed it while reading 'make xconfig',
but never use it (I don't lose track of my .config files, been doing
that tooo long).  Try reading the source for how this is supposed to
work.  You might look around a bit, such as in /boot, as many distros
include the config someplace.

