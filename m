Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264881AbRFYQu1>; Mon, 25 Jun 2001 12:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264880AbRFYQuR>; Mon, 25 Jun 2001 12:50:17 -0400
Received: from mail.primacom.net ([62.208.91.33]:9959 "EHLO mail.primacom.net")
	by vger.kernel.org with ESMTP id <S264881AbRFYQuH>;
	Mon, 25 Jun 2001 12:50:07 -0400
Message-ID: <3B378830.579A6DD@evision.ag>
Date: Mon, 25 Jun 2001 20:51:28 +0200
From: Martin Dalecki <dalecki@evision.ag>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in 3c905 driver.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a note...

This card get's detected twofold by the plain 2.4.5 kernel.
It get's listed twice under both lspci and during the kernel boot
sequence on a HP LHr3 system.
