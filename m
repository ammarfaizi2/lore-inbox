Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUDSVjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUDSVjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUDSVjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:39:31 -0400
Received: from hera.kernel.org ([63.209.29.2]:56271 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261904AbUDSVj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:39:29 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: initramfs howto?
Date: Mon, 19 Apr 2004 21:39:10 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c61gtu$olc$1@terminus.zytor.com>
References: <1081451826.238.23.camel@clubneon.priv.hereintown.net> <buo4qrt4pga.fsf@mcspd15.ucom.lsi.nec.co.jp> <1081531299.19918.13.camel@serpentine.pathscale.com> <200404192048.29666.chris@ukpost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1082410750 25262 63.209.29.3 (19 Apr 2004 21:39:10 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 19 Apr 2004 21:39:10 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200404192048.29666.chris@ukpost.com>
By author:    Chris Lingard <chris@ukpost.com>
In newsgroup: linux.dev.kernel
> 
> linuxrc already exists for initrd systems, and is coded in anyway.
> 

NO NO NO NO NO NO NO NO NO NO NO ...

Calling it /linuxrc instead of /sbin/init was a bad idea to begin with
.. let's not make it worse by making it magic...

	-hpa

