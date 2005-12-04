Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVLDWfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVLDWfR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 17:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVLDWfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 17:35:17 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:56793 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S932358AbVLDWfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 17:35:16 -0500
Message-ID: <43936F18.4060907@shadowconnect.com>
Date: Sun, 04 Dec 2005 23:35:04 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make i2o_iop_free() static inline
References: <20051203122439.GE31395@stusta.de>
In-Reply-To: <20051203122439.GE31395@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Adrian Bunk wrote:
> It's only a micro-optimizatin, but why not save a few bytes?

I fully agree :-)

Thanks!

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>

Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
