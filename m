Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTIOQdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbTIOQdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:33:07 -0400
Received: from smtp.terra.es ([213.4.129.129]:43917 "EHLO tfsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S261546AbTIOQdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:33:05 -0400
From: CASINO_E <CASINO_E@teleline.es>
To: Justin Cormack <justin@street-vision.com>
Cc: Jens Axboe <axboe@suse.de>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Reply-To: casino_e@terra.es
Message-ID: <f3d33f430c.f430cf3d33@teleline.es>
Date: Mon, 15 Sep 2003 18:33:01 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: es
Subject: Re: SII SATA request size limit
X-Accept-Language: es
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately the bug isnt exactly this (apparently) and is only
> revealed under NDA (see Alan Cox's mail).

If I get this post correctly 
(http://www.ussg.iu.edu/hypermail/linux/kernel/0306.0/0764.html), the 
bug is at least close to this. I understand that Alan's mail refers to 
which particular combinations of chip revisions and disk drives are 
affected, so that is why the workaround is applied to all the cases.

Eduardo.



