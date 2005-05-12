Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVELMpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVELMpj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVELMpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:45:39 -0400
Received: from darkgate.equinoxe.de ([217.22.192.6]:43723 "HELO
	darkgate.equinoxe.de") by vger.kernel.org with SMTP id S261751AbVELMpf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:45:35 -0400
From: "Florian Werner" <fwerner@k1024.de>
To: <linux-kernel@vger.kernel.org>
Subject: 
Date: Thu, 12 May 2005 14:45:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcVW8Huso5ApIuxzQI+a8177OAFNwQ==
Message-Id: <20050512124439.4120380EEEB@chaos.k1024.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

i managed to get my new S-ATA Plextor PX-712SA DVD-Burner working by
changing /usr/src/linux/include/linux/libata.h

from:
#undef ATA_ENABLE_ATAPI
to
#define ATA_ENABLE_ATAPI

now i can mount dvds and cds but i am not able to burn!
any hints?

greets
flower

