Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265488AbTFWM0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 08:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbTFWM0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 08:26:22 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:50482 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S265488AbTFWM0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 08:26:21 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01405345@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: linux-kernel@vger.kernel.org
Subject: path entries
Date: Mon, 23 Jun 2003 14:25:13 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
	What's the best way to have the statfs->f_files with an fs _without_
that arg in it's native sb ?
Do we have vfs alternatives ?

Regards,
Fabian
