Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267974AbRGVNBw>; Sun, 22 Jul 2001 09:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267972AbRGVNBm>; Sun, 22 Jul 2001 09:01:42 -0400
Received: from mx10.port.ru ([194.67.57.20]:46292 "EHLO mx10.port.ru")
	by vger.kernel.org with ESMTP id <S267974AbRGVNB1>;
	Sun, 22 Jul 2001 09:01:27 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: ReiserFS report
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.30.63]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15OIrC-000HTk-00@f5.mail.ru>
Date: Sun, 22 Jul 2001 17:01:14 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

   Hello there,
Reporting about linux-2.4.4/3.x.0k-pre8
 1. Wow! Actually 1st time i hadnt tail corruption
 when again revived my partition with --rebuild-tree.
  Good work!
 
 2. Erm, --fix-non-critical says: 
    bla-bla-bla
    there are 6 corruptions what can be fixed with
    fix-fixable
    bla-bla-bla...
  i`m trying to be clever, and run --fix-fixable
AND: _it finds nothing offensive_!!!
  ofcourse --fix-non-critical finds these
  stale 6 errors..... quite disappointing :(

---
cheers,


   Samium Gromoff
