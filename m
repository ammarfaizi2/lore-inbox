Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSHJIhO>; Sat, 10 Aug 2002 04:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSHJIhO>; Sat, 10 Aug 2002 04:37:14 -0400
Received: from server.gullivertoys.hu ([212.108.196.206]:45580 "EHLO
	server.atom.hu") by vger.kernel.org with ESMTP id <S316674AbSHJIhM>;
	Sat, 10 Aug 2002 04:37:12 -0400
Date: Sat, 10 Aug 2002 10:40:47 +0200
From: RISKO Gergely <risko@atom.hu>
To: linux-kernel@vger.kernel.org
Subject: rootfstype and rootflags not documented in kernel_parameters.txt
Message-ID: <20020810084047.GA4740@atom.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

In kernel 2.4.19 the rootfstype and rootflags option isn't documented,
and it isn't an easy task to search them out from the source (espicially
if the one who do it is not a kernel hacker...).

Please give them two line at least. And in the BootPrompt-HOWTO this
options also can't be found.

Thanks,
Gergely
