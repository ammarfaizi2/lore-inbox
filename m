Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbVIVVTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbVIVVTO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbVIVVTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:19:14 -0400
Received: from opersys.com ([64.40.108.71]:18181 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1030361AbVIVVTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:19:13 -0400
Message-ID: <43332254.1040603@opersys.com>
Date: Thu, 22 Sep 2005 17:29:56 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: sean.bruno@dsl-only.net, ak@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: The system works (2.6.14-rc2): functional k8n-dl
References: <20050922155254.GE5910@us.ibm.com>
In-Reply-To: <20050922155254.GE5910@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nish,

OK, I can confirm that with version 1006 of the BIOS it works flawlessly
with Linux. I was able to install full FC4 and boot without a problem
even with the SATA disk plugged to the nVidia controller (reading the
archives you will see that the nVidia SATA controller is something I
was simply unable to get working.) I didn't need to recompile anything.
The kernel that came with FC4 worked just fine.

This is great news. That box had been sitting on my rack for the past
couple of months because I was just not able to get Linux to work
properly. I had figured I would put a cheap network card in there just
to get things started, but it really wasn't doing what I bought it
for. Now it works as would be expected.

Hopefully next time ASUS releases a board they actually test that it
works with all major OSes before making the release. In this case, I
feel as if I was tricked into buying a board that really didn't perform
as planned, and as a result I wasted lots of time which could been for
more productive work.

Thanks again for the heads up.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
