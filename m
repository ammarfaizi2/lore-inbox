Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVB0XD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVB0XD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 18:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVB0XD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 18:03:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:59712 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261511AbVB0XDF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 18:03:05 -0500
Date: Sun, 27 Feb 2005 17:58:49 -0500
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: ext3 bug
In-reply-to: <200502271406.30690.kernel-stuff@comcast.net>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <1109545130.7940.2.camel@localhost>
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
MIME-version: 1.0
X-Mailer: Evolution 2.0.3
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
References: <1109487896.8360.16.camel@localhost>
 <200502271406.30690.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please try stock kernel. 2.6.11-rc3 onwards should be fine. - I saw a similar 
> problem while running 2.6.10 kernel from Fedora Core 3. It doesn't happen 
> with stock kernels.

I did use a stock 2.6.10 kernel (I said custom in the sense that it
wasn't a Debian kernel). After a reboot, I was able to run fsck on the
disk (many, many errors) and it went fine after.

	Jean-Marc

-- 
Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Université de Sherbrooke

