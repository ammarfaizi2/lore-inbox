Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbREVRl5>; Tue, 22 May 2001 13:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262687AbREVRlr>; Tue, 22 May 2001 13:41:47 -0400
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:54524 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S262685AbREVRle>; Tue, 22 May 2001 13:41:34 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880A7F@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: linux-kernel@vger.kernel.org
Subject: why DMAable memory restriction ?
Date: Tue, 22 May 2001 11:41:12 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LIst,

In the linux kernel there is a limitation on the
amount of contiguous DMAable memory that can be allocated
(I guess about 128K). Does anobody know what is the reason
for such a restriction ? Is there any plan to remove
this restriction in the future releases of kernel ?

Regards,
-hiren
(408)970-3062
hiren_mehta@agilent.com
