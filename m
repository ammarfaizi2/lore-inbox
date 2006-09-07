Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422712AbWIGSNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712AbWIGSNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWIGSNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:13:35 -0400
Received: from main.gmane.org ([80.91.229.2]:7850 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161078AbWIGSNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:13:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
Date: 07 Sep 2006 20:06:14 +0200
Message-ID: <87k64fimax.fsf@willow.rfc1149.net>
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <44FEAD7E.6010201@draigBrady.com> <45005657.8000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jim" == Jim Cromie <jim.cromie@gmail.com> writes:

Jim> Pádraig Brady wrote:
>> Is W83697HG a good name?
>> 


Jim> could you add a suffix, say _watchdog ?

Jim> the name youve got is confusingly close to the convention used in
Jim> drivers/hwmon

The module is named as others in drivers/char/watchdog: w83697hf_wtd.c

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

