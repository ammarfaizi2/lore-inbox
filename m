Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTDRGT6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 02:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTDRGT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 02:19:58 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:41732 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id S262882AbTDRGT6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 02:19:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
Message-Id: <200304180827.40934@gandalf>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.67-ac2
Date: Fri, 18 Apr 2003 08:32:05 +0200
X-Mailer: KMail [version 1.3.2]
References: <200304172319.h3HNJXJ31933@devserv.devel.redhat.com>
In-Reply-To: <200304172319.h3HNJXJ31933@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 April 2003 01:19, Alan Cox wrote:
> Next set of updates. Cautionary words still appy.
> 
> Handle with care, no naked flames, do not inhale....

It compiles, but it does not boot:
kernel panic: cannot find init

this is with devfs enabled and mounted at boot.
I can't find anything in the lists although I thought I saw someone reporting 
a similar problem.
will try it without devfs

	Rudmer
