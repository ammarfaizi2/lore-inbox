Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161317AbWF0Vgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161317AbWF0Vgf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWF0Vgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:36:35 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:35237 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1161317AbWF0Vgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:36:35 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: broken auto-repeat on PS/2 keyboard
Date: Tue, 27 Jun 2006 23:37:39 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       Paolo Ornati <ornati@fastwebnet.it>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606272337.40724.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-01.tornado.cablecom.ch 1377;
	Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i noticed the problem as well here...and i can confirm that your patch
fixes the problem...

andrew, have a look at:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=115142991330291&w=4

thanks
-daniel
