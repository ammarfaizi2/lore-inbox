Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTGKQFY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbTGKQFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:05:24 -0400
Received: from ip212-226-133-178.adsl.kpnqwest.fi ([212.226.133.178]:18377
	"EHLO jumper") by vger.kernel.org with ESMTP id S263738AbTGKQFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:05:21 -0400
To: linux-kernel@vger.kernel.org
Subject: hang with pcmcia wlan card
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
Date: Fri, 11 Jul 2003 19:20:46 +0300
Message-ID: <87fzldxcf5.fsf@jumper.lonesom.pp.fi>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

 My laptop (thinkpad 570e) hangs hard straight after bringing up 
 interface with d-link dwl-650 wlan card. 2.5.73-bk1 works and
 2.5.73-bk2 to 2.5.75-bk1 hang. If I boot without the card, 
 everything comes up, but inserting the card results to a hang.
 Setting nmi_watchdog=2 has no effect. 
 
 So, what to try next?

                        --j
 
