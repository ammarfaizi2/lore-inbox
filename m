Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVEZCwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVEZCwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 22:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVEZCwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 22:52:44 -0400
Received: from opersys.com ([64.40.108.71]:26373 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261167AbVEZCwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 22:52:40 -0400
Message-ID: <42953C7B.9080708@opersys.com>
Date: Wed, 25 May 2005 23:03:23 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: WxWorks side-by-side with Linux over ... Jaluna
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For those still following the RT debate, here's an example deployment
(albeit proprietary) of the nanokernel approach:
http://linuxdevices.com/news/NS4058764254.html

rtai-fusion, which relies on the nanokernel/hypervisor approach, is
an open source substitute to the above. It was designed to provide
RTOS skins (posix, VxWorks, pSOS, uITRON, VRTX) on top of an
rt-nucleus, all of which runs side-by-side with Linux.

customary warning: none of this precludes coexistence with rt-preempt.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
