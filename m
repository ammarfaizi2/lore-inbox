Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTLHUG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTLHUG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:06:27 -0500
Received: from ns1.skjellin.no ([80.239.42.66]:6564 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S261807AbTLHUG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:06:26 -0500
Subject: Re: [EXT3] SuperBlock Corrution with "data=journal" ?
From: Andre Tomt <lkml@tomt.net>
To: Marcello <voloterreno@tin.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3FD4D4E4.5050906@tin.it>
References: <3FD4D4E4.5050906@tin.it>
Content-Type: text/plain
Message-Id: <1070913966.15415.489.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Dec 2003 21:06:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-08 at 20:45, Marcello wrote:
> Hi all ,
> 
> I've heard of a bug in EXT3 , that mounted with "data=journal" option 
> corrupts the file system , this is still present on 2.4.23 ??
> 
> "data=journal" is safe?

The "data=journal"-bug was fixed between 2.4.20 and 2.4.21, about a year
ago in BK. So, unless there is a new one..


