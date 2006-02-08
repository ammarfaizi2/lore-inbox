Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030567AbWBHGQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030567AbWBHGQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbWBHGQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:16:14 -0500
Received: from outmx017.isp.belgacom.be ([195.238.4.116]:17361 "EHLO
	outmx017.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030565AbWBHGQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:16:13 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: No-execute support?
Date: Wed, 8 Feb 2006 07:16:08 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602080716.08360.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

Hope I'm not gonna drag up a dead horse or so, but since I recently acquired a 
laptop with NX support, I was wondering if in the end it made it into the 
kernel, or newer patches are available to test it out.

The only reference I seem to find is at 

http://people.redhat.com/mingo/nx-patches/

but this dates from 2.6.7, which is about half a century ago. ;)

Thanks,

Jan

-- 
"A verbal contract isn't worth the paper it's printed on."
		-- Samuel Goldwyn
