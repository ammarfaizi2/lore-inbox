Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTJHXqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 19:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTJHXp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 19:45:29 -0400
Received: from dialup-188.153.220.203.acc01-ball-lis.comindico.com.au ([203.220.153.188]:57348
	"EHLO mummy.lan.sky.net.au") by vger.kernel.org with ESMTP
	id S261820AbTJHXpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 19:45:05 -0400
Message-ID: <007701c38df5$7639a8a0$1400a8c0@lan.sky.net.au>
Reply-To: "Jai" <jai@linknet.com.au>
From: "Jai" <jai@linknet.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: matroxfb problem
Date: Thu, 9 Oct 2003 09:39:48 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi all,

I'm running kernel-2.4.20, I have enabled frame buffer support for matrox
G550 in the kernel, but get these messages on boot:

matroxset: Matrox G550 detected
matroxset: MTRR's turned on
matroxfb: cannot set required perameters

and of course /dev/fb0 and fb1 are not available.

I have also tried it with kernel-2.4.22, I believe I have seen this working
before but I can't seem remember what it is i havn't done.
Has anyone got any light to shed on this.

Thanks for your time. Please CC me with any replies.

Kind Regards,
Jai.

