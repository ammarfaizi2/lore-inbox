Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUAOOhc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 09:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbUAOOhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 09:37:31 -0500
Received: from [212.174.195.226] ([212.174.195.226]:29650 "EHLO
	uekae.uekae.gov.tr") by vger.kernel.org with ESMTP id S265062AbUAOOha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 09:37:30 -0500
Subject: True story: "gconfig" removed root folder...
From: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: TUBITAK - Ulusal Elektronik ve Kriptoloji Arastirma Enstitusu
Message-Id: <1074177405.3131.10.camel@oebilgen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 16:36:45 +0200
Content-Transfer-Encoding: 7bit
X-Pyzor: Reported 0 times.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Today I downloaded 2.6.1 kernel and tried to configure it with "make
gconfig". After all changes I selected "Save As" and clicked "/root"
folder to save in. Then I clicked "OK", without giving a file name. I
expected that it opens root folder and lists contents. But this magic
configurator removed (rm -Rf) my root folder and created a file named
"root". It was a terrible experience!..

Please fix this. I didn't check that same problem (I even didn't launch
them) exist for other configurators then gconfig.

I send this mail here because I guessed that the configurator is a part
of kernel.

Note: (As you wished) Please CC me your responses.


TIA
-- 
Comp. Eng. Ozan Eren BILGEN

TUBITAK - UEKAE (Turkey)
National Research Institute of Electronics & Cryptology
Special Projects Group
Researcher


