Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUDVQST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUDVQST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbUDVQST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:18:19 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:17675 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S264358AbUDVQSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:18:12 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse: fix mouse hotplugging
In-Reply-To: <200404221546.i3MFka6w004059@eeyore.valparaiso.cl>
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.6-rc2 (i686))
Message-Id: <E1BGgu7-0001t3-Qt@rhn.tartu-labor>
Date: Thu, 22 Apr 2004 19:18:23 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HvB> I have seen "hoplugging of mice" fry PS/2 ports, and heard of motherboards
HvB> killed that way. 

AFAIK, PS/2 ports are since 1998 specified to be able to handle
hotplugging in the sense that they must not fry when devices are plugged
at runtime (but I don't remeber about any need to be able to _use_ these
hotplugged devices).

-- 
Meelis Roos
