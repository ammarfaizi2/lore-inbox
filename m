Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbUAYWUH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbUAYWUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:20:06 -0500
Received: from desnol.ru ([217.150.58.74]:28177 "EHLO desnol.ru")
	by vger.kernel.org with ESMTP id S262965AbUAYWUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:20:04 -0500
Date: Mon, 26 Jan 2004 01:20:02 +0300
From: Agri <agri@desnol.ru>
To: linux-kernel@vger.kernel.org
Subject: loading ide-scsi on demand
Message-Id: <20040126012002.4f4b6f28.agri@desnol.ru>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I asked this question on newbie list... but got no idea...

Is there any way to configure loading of ide-scsi "ON DEMAND"?
It seems that "touching" for /dev/scd0 do not cause kmod
to exec modprobe.

Agri

