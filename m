Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265785AbUFORfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUFORfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUFORfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:35:38 -0400
Received: from castle.comp.uvic.ca ([142.104.5.97]:2993 "EHLO
	castle.comp.uvic.ca") by vger.kernel.org with ESMTP id S265785AbUFORfd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:35:33 -0400
Subject: ppc64 2.6.6 crash
From: Owen Stampflee <ostampflee@terrasoftsolutions.com>
To: linuxppc-dev@lists.linuxppc.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1087320805.14795.216.camel@koobi.lan.stampflee.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2a) 
Date: 15 Jun 2004 10:33:25 -0700
Content-Transfer-Encoding: 7bit
X-UVic-Virus-Scanned: OK - Passed virus scan by Sophos (sophie) on castle
X-UVic-Spam-Scan: castle.comp.uvic.ca Not_scanned_LOCAL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm having the following issue using linux 2.6.6 compiled for ppc64 on a
single 1.8GHz G5 that is triggered by kudzu.A photo of the backtrace is
available at http://cvs.terraplex.com/~owen/s3000018.jpg The strace
output is available at http://cvs.terraplex.com/~owen/kudzu.strace. It
appears to be doing something with tg3 which the machine has but I could
be totally wrong. I should also note that 2.6.6-rc3 works fine.

Sincerly,
Owen

-- 
Owen Stampflee                  ostampflee@terrasoftsolutions.com
Lead Developer, Yellow Dog Linux.    http://cvs.terraplex.com/~owen

