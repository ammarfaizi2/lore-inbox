Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWBJNk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWBJNk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWBJNkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:40:25 -0500
Received: from mail.astral.ro ([193.230.240.11]:24494 "EHLO mail.astral.ro")
	by vger.kernel.org with ESMTP id S1751114AbWBJNkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:40:25 -0500
Message-ID: <43EC97C6.10607@astral.ro>
Date: Fri, 10 Feb 2006 15:40:22 +0200
From: Imre Gergely <imre.gergely@astral.ro>
Organization: Astral Telecom SA
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: disabling libata
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi

i have a SATA hardisk, and am using FC4 with default kernel
(2.6.14-1.1644_FC4). i was wondering if it's possible to tell the kernel to use
the old ATA driver with SATA support instead of libata, for my harddisk to
appear as hdX, and not sdX.


(please CC the answers, as i'm not on the list)

thank you.

