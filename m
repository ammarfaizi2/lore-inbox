Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272666AbRIMBtV>; Wed, 12 Sep 2001 21:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272672AbRIMBtL>; Wed, 12 Sep 2001 21:49:11 -0400
Received: from mx5.port.ru ([194.67.57.15]:61712 "EHLO smtp5.port.ru")
	by vger.kernel.org with ESMTP id <S272666AbRIMBs5>;
	Wed, 12 Sep 2001 21:48:57 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109130611.f8D6BfV01791@vegae.deep.net>
Subject: OOPS handling proposal
To: linux-kernel@vger.kernel.org
Date: Thu, 13 Sep 2001 06:11:40 +0000 (UTC)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hello folks!
    People most likely needs first oops most of the time, so
  it would be great to make a kernel boot option to stop after
  first oops, so in the situations when its neede life can be made easy.
    Actually afaics this is being done each time by hand, so 
  panic() in BUG() as Rik proposed would be nice.
    What do you folks think?

cheers, Sam
