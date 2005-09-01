Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030554AbVIAXzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030554AbVIAXzn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbVIAXzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:55:43 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:13920 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1030554AbVIAXzn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:55:43 -0400
Date: 02 Sep 2005 01:55:34 +0200
From: Sebastian Fabrycki <cellsan@interia.pl>
Subject: I have Dothan stepping 6, is that C1?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-ORIGINATE-IP: 80.51.216.133
IMPORTANCE: Normal
X-MSMAIL-PRIORITY: Normal
X-PRIORITY: 3
X-Mailer: PSE3
Message-Id: <20050901235534.65A0D2334E4@poczta.interia.pl>
X-EMID: 33240acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Pentium M / Dothan steppings are: A1, A2, B0, B1, C0, C1. My /proc/cpuinfo shows stepping 6. Does this mean i have stepping C1?

If so, then can i compile cpufreq tables into kernel? I have centrino laptop without those tables in ACPI.
st3 wrote:
The only issue is that there are four different versions of Dothan CPUs for
A1, A2, B0, B1, C0 steppings. There is only one version for C1 stepping.

So, if i have C1 Dothan then i can compile voltage tables into kernel?

If yes, then can someone send me patch for kernel version 2.6.13 ?

I'm not subscribed to the list, please CC me.
-- 
Regards


----------------------------------------------------------------------
Jedyny taki czat... >>> http://link.interia.pl/f18b0

