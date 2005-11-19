Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbVKSVP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbVKSVP5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVKSVP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:15:56 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43700 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750836AbVKSVP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:15:56 -0500
Subject: Re: Kernel panic: Machine check exception
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Avuton Olrich <avuton@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3aa654a40511191254x4bf50cc8l6a9b8786f1a5ebc8@mail.gmail.com>
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
	 <1132406652.5238.19.camel@localhost.localdomain>
	 <3aa654a40511191254x4bf50cc8l6a9b8786f1a5ebc8@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Nov 2005 21:48:06 +0000
Message-Id: <1132436886.19692.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-11-19 at 12:54 -0800, Avuton Olrich wrote:
> Is there a good way to narrow it down? I guess running a badmem
> program would be good to start with, otherwise ...(?).

A memory test may be worth doing but most machine checks indicate the
fault is more serious than bad memory.

