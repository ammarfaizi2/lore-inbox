Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270953AbTGPO21 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270948AbTGPO20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:28:26 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:48578 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S270926AbTGPO2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:28:25 -0400
From: Oliver Neukum <oliver@neukum.org>
To: linux-kernel@vger.kernel.org
Subject: usability of device nodes with devfs
Date: Wed, 16 Jul 2003 16:42:05 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307161642.05966.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is it a requirement that nodes created with devfs can be opened
successfully from the moment the device is registered?

	Regards
		Oliver

