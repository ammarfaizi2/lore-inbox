Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270467AbRIAMFj>; Sat, 1 Sep 2001 08:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270495AbRIAMFc>; Sat, 1 Sep 2001 08:05:32 -0400
Received: from mx2.port.ru ([194.67.57.12]:8198 "EHLO smtp2.port.ru")
	by vger.kernel.org with ESMTP id <S270467AbRIAMFY>;
	Sat, 1 Sep 2001 08:05:24 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109011628.f81GS6R01079@vegae.deep.net>
Subject: is bzImage container large enough?
To: linux-kernel@vger.kernel.org
Date: Sat, 1 Sep 2001 16:28:06 +0000 (UTC)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

      If one wanting to turn on virtually every kernel CONFIG_* option
  in order to check if the kernel compiles and then report possible
  gcc errors to lkml, will the resulting kernel fit the bzImage format?
  Will the bootup be possible?

  thanks in advance...

cheers,
 Sam
