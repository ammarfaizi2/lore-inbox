Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269481AbRIDWCm>; Tue, 4 Sep 2001 18:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269428AbRIDWCd>; Tue, 4 Sep 2001 18:02:33 -0400
Received: from mx9.port.ru ([194.67.57.19]:62399 "EHLO mx9.port.ru")
	by vger.kernel.org with ESMTP id <S269421AbRIDWCS>;
	Tue, 4 Sep 2001 18:02:18 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109050225.f852P6g07976@vegae.deep.net>
Subject: procFS performance
To: linux-kernel@vger.kernel.org
Date: Wed, 5 Sep 2001 02:25:05 +0000 (UTC)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

         Why procfs-related apps eats so much performance?
   for example - top eats 4.1% of p166 cpu. Also they seem to be a cause
   for big latencies...
      is this sane?

