Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVG0R3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVG0R3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVG0R3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:29:21 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:6558 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261321AbVG0R3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:29:19 -0400
Message-ID: <42E7C041.1030005@t-online.de>
Date: Wed, 27 Jul 2005 19:11:29 +0200
From: Michael Berger <mikeb1@t-online.de>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: vikas.g@ap.sony.com, jengelh@linux01.gwdg.de
Subject: Re: Build error in Kernel 2.6.13-rc3 git current
References: <4uNU4-4Ii-15@gated-at.bofh.it>
In-Reply-To: <4uNU4-4Ii-15@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: Saf28mZVoerBZ23sVLBpkAKCWf8xm3ReILlY96NCtdrNgWPdsafOZj
X-TOI-MSGID: 6028dc9e-d49d-494c-9107-e36f773a0832
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Vikas and Jan Engelhardt,

thank you for your answers. I found out that after reverting the patch
[PATCH] i386: clean up user_mode_macros, Author Chuck Ebbert [git SHA1
ID: ae6578fe9b65208dee8eda40629984efd23740c4] I can compile and boot the
  current git kernel.

Best regards,

-- Michael Berger


