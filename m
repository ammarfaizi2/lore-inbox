Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTEZV3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 17:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTEZV3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 17:29:05 -0400
Received: from pointblue.com.pl ([62.89.73.6]:16658 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262253AbTEZV3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 17:29:04 -0400
Subject: Re: 2.5.69-bk13 USB storage ,few errors
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Oliver Neukum <oliver@neukum.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200305262205.38256.oliver@neukum.org>
References: <1053972173.1968.18.camel@nalesnik.localhost>
	 <200305262205.38256.oliver@neukum.org>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1053984606.3650.0.camel@nalesnik.localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 22:30:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-26 at 21:05, Oliver Neukum wrote:
> > this is sony vaio pcg-c1ve notebook
> > USB storage on 2.4.21-rc3 does not say anything in dmesg, and works just
> > perfect.
> 
> Does it work on 2.5? Your dmesg has no errors.
no, it does not on 2.5.69-bk19
/dev/scsi dir is empty (devfs)

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

