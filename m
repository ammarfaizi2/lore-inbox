Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318739AbSIJFZo>; Tue, 10 Sep 2002 01:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318993AbSIJFZo>; Tue, 10 Sep 2002 01:25:44 -0400
Received: from mx9.mail.ru ([194.67.57.19]:19467 "EHLO mx9.mail.ru")
	by vger.kernel.org with ESMTP id <S318739AbSIJFZn>;
	Tue, 10 Sep 2002 01:25:43 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [2.5] DAC960
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 194.226.0.89 via proxy [194.226.0.63]
Date: Tue, 10 Sep 2002 09:30:28 +0400
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E17odbY-000BHv-00@f1.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

      Hello folks, i`m looking at the DAC960 driver and i have
realised its implemented at the block layer, bypassing SCSI.

   So given i have some motivation to have a working 2.5 DAC960
driver (i have one, being my only controller)
i`m kinda pondering the matter.

   Questions:
       1. Whether we need the thing to be ported to SCSI
layer, as opposed to leaving it being a generic block device? (i suppose yes)
       2. Which 2.5 SCSI driver should i use as a start of learning?
       3. Whether the SCSI driver API would change during 2.5?

---
regards,
   Samium Gromoff
____________
________________________________


