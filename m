Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUGSDhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUGSDhC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 23:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUGSDhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 23:37:02 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:34220 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S264660AbUGSDhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 23:37:00 -0400
Message-ID: <40FBEA97.C4BCA3B3@austin.rr.com>
Date: Mon, 19 Jul 2004 10:36:56 -0500
From: Steven French <smfrench@austin.rr.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, cspalletta@yahoo.com
Subject: [PATCH] Remove prototypes of nonexistent functions from fs/cifs files
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have now removed the dead prototypes via the following changeset into
the cifs development bk tree.  See patch:

http://cifs.bkbits.net:8080/linux-2.5cifs/gnupatch@40fb3f61nxIM7ayUoQkK7NCPxdqEuw

but it may be a week or more before it gets merged due to OLS.   Thanks
for pointing these out.

