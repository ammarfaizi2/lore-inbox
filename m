Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280612AbRKBJAx>; Fri, 2 Nov 2001 04:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280607AbRKBJAo>; Fri, 2 Nov 2001 04:00:44 -0500
Received: from mx6.port.ru ([194.67.57.16]:16147 "EHLO smtp6.port.ru")
	by vger.kernel.org with ESMTP id <S280606AbRKBJAb>;
	Fri, 2 Nov 2001 04:00:31 -0500
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200111020902.fA292A818161@vegae.deep.net>
Subject: OOM /proc logging
To: andrea@suse.de
Date: Fri, 2 Nov 2001 12:02:06 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, riel@surriel.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hello folks...
     After another complain on #kernelnewbies about the OOM killer doing
  strange thingss, by killing small processes when its really not needed,
  and not doing anything when its really OOM i ran out of nerves and came out
  with an idea, which i believe already settled down is some brains.
    I speak about providing in /proc list of process badnesses, possibly with
  some additional info...
    Its just a shame to have a stable kernel randomly killing processes even when 
  its not needed...

  (this message was planned as answer to Linus request for any kind of VM bitchig....)

regards, Samium Gromoff
