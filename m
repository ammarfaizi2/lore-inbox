Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265569AbTGCIiH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 04:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265572AbTGCIiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 04:38:07 -0400
Received: from va-leesburg1b-227.chvlva.adelphia.net ([68.64.41.227]:45187
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S265569AbTGCIiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 04:38:06 -0400
To: linux-kernel@vger.kernel.org
Subject: dmesg problem in 2.5.73
From: John Covici <covici@ccs.covici.com>
Date: Thu, 03 Jul 2003 04:52:31 -0400
Message-ID: <m3he64c7qo.fsf@ccs.covici.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I have a weird problem -- maybe its iptables, but I am using the
log target and they print at legvel 4, but I only want level 3 or
less to print on the console, so I did 'dmesg -n 3' but I am still
getting the iptables messages.

I thought I could do this all with syslog.conf, but that has never
worked.

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
