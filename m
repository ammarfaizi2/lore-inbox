Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVKGHFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVKGHFd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 02:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVKGHFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 02:05:18 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:19641 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964802AbVKGHFQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 02:05:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oHFy9I/AhL3ePLLNiER0m3wE/V/y2KDqLE1iQOmaXHGQWaY0/C0QUzUu2p7WDNHwZtv591UKQDzyCZIMx6dLumGOAQftniipU12gJ9Rb5dtUP6Br4fPLjlHNj2P7YJe2lHzQRxtcGhOXF5/77L1v2oGu9v5pxF+QORx1cKbPkb4=
Message-ID: <a44ae5cd0511062305i410dcf0fy8a97a36b74150507@mail.gmail.com>
Date: Mon, 7 Nov 2005 02:05:16 -0500
From: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.14-mm1 -- unknown symbol alsa_card_saa7134_create
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: /lib/modules/2.6.14-mm1/kernel/drivers/media/video/saa7134/saa7134.ko
needs unknown symbol alsa_card_saa7134_create
WARNING: /lib/modules/2.6.14-mm1/kernel/drivers/media/video/saa7134/saa7134.ko
needs unknown symbol alsa_card_saa7134_exit
WARNING: /lib/modules/2.6.14-mm1/kernel/drivers/media/video/saa7134/saa7134.ko
needs unknown symbol saa7134_irq_alsa_done
