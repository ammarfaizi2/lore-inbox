Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTIVMfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 08:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbTIVMfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 08:35:41 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:24228 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S263131AbTIVMfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 08:35:38 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01E2567C@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: [PPC MM] mem_pieces
Date: Mon, 22 Sep 2003 14:35:29 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Maybe we could drop mem_pieces_append ? It's not used anywhere...

Regards,
Fabian
