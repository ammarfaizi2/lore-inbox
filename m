Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267471AbTHJNaP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 09:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbTHJNaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 09:30:15 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:1650 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S267471AbTHJNaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 09:30:13 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B014053AE@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH ?] iprune_sem
Date: Sun, 10 Aug 2003 15:30:10 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Someone could tell me why we don't use iprune_sem in get_new_inode
like this ?
	http://fabian.unixtech.be/kernel/inode060803.diff


Regards,
Fabian
