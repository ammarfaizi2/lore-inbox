Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWB1AzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWB1AzP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWB1AzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:55:14 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:43473 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750952AbWB1AzM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:55:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H0ugZLG+X+dz/bVe0+20O+g4cwSgBbmNollgMpIfwXg5l2O4YQcKOXsUWjcW3GaoabkLgfIQ7gauLQ+PRCm/tU19Uh7Y1ynnwRDll6PbCzXQ9GtfdZ/BvMcaDsHDnXAKSfoRocxfRL5K0AV7HSoChQKRphzFRoytd0jE2SkC9ic=
Message-ID: <cbec11ac0602271655p70669d4bi99096282a5e0b86e@mail.gmail.com>
Date: Tue, 28 Feb 2006 13:55:08 +1300
From: "Ian McDonald" <imcdnzl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Problem making kernel with debian unstable due to make upgrade
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

If anybody else is banging their heads against the wall and uses
debian unstable this seems to be due to a make bug in the current
version.

In particular mine happened with make going from 3.80+3.81.b4-1 to
3.80+3.81.rc1-1

There is a bug report at http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=354602

Just to let you know as I'm sure others of you will soon be as
frustrated as me - particularly when I have a box that takes an hour
to compile....

Ian
--
Ian McDonald
Web: http://wand.net.nz/~iam4
Blog: http://imcdnzl.blogspot.com
WAND Network Research Group
Department of Computer Science
University of Waikato
New Zealand
