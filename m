Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVGXNoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVGXNoW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 09:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVGXNoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 09:44:21 -0400
Received: from hermes.uci.kun.nl ([131.174.93.58]:2200 "EHLO hermes.uci.kun.nl")
	by vger.kernel.org with ESMTP id S261225AbVGXNoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 09:44:20 -0400
Date: Sun, 24 Jul 2005 15:36:43 +0200
From: Arnout Engelen <arnouten@bzzt.net>
X-Face: .NTzn{Sdm0J?lRrT!!ZlD*F.4iAkyy+A$,QfVsVBz.,k4QFi66b]ykR.Y..HR{OM>4b,9..
 |we.b[Oi![,fv-=7w.oRq>9.HIi$7.P*nSW=3p&*r91H=_h,b.4<C'oSg2eUfHPO8%wVoP^i_TyAZ.
 h0I(cIjB=..hc436%E(QM.Qg[z~|]7.5-X>s.X*caTn}0NY"A.q<+[wb~N2
Subject: Re: [PATCH] Filesystem capabilities support
To: linux-kernel@vger.kernel.org
Message-id: <20050724133643.GF10610@bzzt.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Hans Simmonds wrote:
> This is a simple attempt at providing capability support

Very good to see progress in this field. I'm not familiar with the 
technical details yet, but this seems an important security feature imho.

How does this patch relate to the one at
http://www.olafdietsche.de/linux/capability ?

I do think the LD_PRELOAD / LD_LIBRARY_PATH problem (also described by
Olaf) should be mentioned in the kernel config, and fs capabilities should 
remain marked EXPERIMENTAL until that's resolved.


Kind regards,

-- 
Arnout Engelen <arnouten@bzzt.net>

  "If it sounds good, it /is/ good."
          -- Duke Ellington
