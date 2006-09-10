Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWIJRq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWIJRq6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWIJRq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:46:58 -0400
Received: from mailfe08.tele2.fr ([212.247.154.236]:7062 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932329AbWIJRq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:46:57 -0400
X-T2-Posting-ID: C+rpYiNZ2NzjjSrGUeFwNg==
X-Cloudmark-Score: 0.000000 []
From: Simon MORIN <simon-morin@laposte.net>
To: linux-kernel@vger.kernel.org
Subject: Re: DMA activation problem on Intel ICH7 82801GBM/GHMA
Date: Sun, 10 Sep 2006 19:46:47 +0200
User-Agent: KMail/1.9.4
References: <200609101201.52167.simon-morin@laposte.net> <45040CC7.9080607@garzik.org>
In-Reply-To: <45040CC7.9080607@garzik.org>
Cc: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609101946.47823.simon-morin@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally, I applied a patch I found on this thread :
http://www.spinics.net/lists/linux-ide/msg04732.html

and it works perfectly. I hope this will be solved in a future kernel release.

Thanks !

Simon Morin
