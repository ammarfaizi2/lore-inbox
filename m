Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265100AbUFGWVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUFGWVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbUFGWVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:21:43 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:731 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265100AbUFGWVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:21:38 -0400
Subject: [PATCH] 2.6.6 memory allocation checks in
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: torque@ukrpost.net
Content-Type: text/plain
Organization: IBM
Message-Id: <1086646703.5214.10.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Jun 2004 17:18:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Adds memory allocation checks in cifs_parse_mount_options().
> ./linux-2.6.6-modified/fs/cifs/connect.c |    4 ++++
> 1 files changed, 4 insertions(+)

I pushed the change to the project tree
	bk://cifs.bkbits.net/linux-2.5cifs
and will send that in with the next group of cifs bk changesets later in
the week.

Thanks.

