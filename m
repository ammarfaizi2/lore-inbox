Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVCYMQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVCYMQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 07:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVCYMQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 07:16:54 -0500
Received: from opersys.com ([64.40.108.71]:48654 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261253AbVCYMQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 07:16:53 -0500
Message-ID: <424403CC.1040702@opersys.com>
Date: Fri, 25 Mar 2005 07:27:56 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: read() on relayfs channel returns premature 0
References: <20050323090254.GA10630@aurema.com> <16961.35656.576684.890542@tut.ibm.com> <20050324012948.GC25134@aurema.com> <16963.4331.617958.820012@tut.ibm.com> <Pine.LNX.4.61.0503242032090.8883@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0503242032090.8883@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jan Engelhardt wrote:
> Hm? Relayfs does not support a `cat /dev/relay/AChannelName` anymore?

This was a requirement for it to be included.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
