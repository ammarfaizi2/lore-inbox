Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272356AbRIEXNb>; Wed, 5 Sep 2001 19:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272359AbRIEXNV>; Wed, 5 Sep 2001 19:13:21 -0400
Received: from mx7.port.ru ([194.67.57.17]:24811 "EHLO mx7.port.ru")
	by vger.kernel.org with ESMTP id <S272356AbRIEXNF>;
	Wed, 5 Sep 2001 19:13:05 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109060335.f863ZnF00627@vegae.deep.net>
Subject: Re: Basic reiserfs question
To: linux-kernel@vger.kernel.org
Date: Thu, 6 Sep 2001 03:35:49 +0000 (UTC)
Cc: mackstevenson@hotmail.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I would like to know whether log replays take place whenever the system is
 > booted or only after it has been incorrectly shutdown. I occasionaly see
 > "Warning, log replay (...)" during the boot-up sequence although the system
 > had been correctly shut down, and I would like to know if I should worry.
    Actually you see "Warning" only when it is replaying log on 
  fs mounted readonly. I wander though why you see it only "occasionally"..
    Normally it replays log every time and you shouldnt bother.

cheers, 
  Sam
