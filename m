Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278073AbRJVHub>; Mon, 22 Oct 2001 03:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278074AbRJVHuV>; Mon, 22 Oct 2001 03:50:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41479 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278073AbRJVHuT>; Mon, 22 Oct 2001 03:50:19 -0400
Subject: Re: Linux 2.4.12-ac5
To: dlitz@dlitz.net (Dwayne C. Litzenberger)
Date: Mon, 22 Oct 2001 08:56:46 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20011021234110.A4193@zed.dlitz.net> from "Dwayne C. Litzenberger" at Oct 21, 2001 11:41:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vZx0-00013V-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, is this normal?
> 
> zed:~# cat /proc/sys/kernel/tainted
> 1
> zed:~# echo "0" >/proc/sys/kernel/tainted
> zed:~# cat /proc/sys/kernel/tainted
> 0
> zed:~#

Its fine. I've not yet worried about making the transition one way like the
capabilities variable
