Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbTH0MRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 08:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTH0MRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 08:17:34 -0400
Received: from 213-0-221-71.dialup.nuria.telefonica-data.net ([213.0.221.71]:34178
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S263356AbTH0MRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 08:17:33 -0400
Date: Wed, 27 Aug 2003 14:17:31 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm1 - kswap hogs cpu OO takes ages to start!
Message-ID: <20030827121731.GA9525@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200308272138.h7RLciK29987@webmail2.vsnl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308272138.h7RLciK29987@webmail2.vsnl.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 27 August 2003, at 16:38:44 -0500,
warudkar@vsnl.net wrote:

> Same thing run under 2.4.18 starts up in 3 minutes, X stays usable and kswapd never take more than 2% CPU.
> 
OpenOffice is know to have severe performance problems with kernels
2.5.x and 2.6.x kernels in the presence of any CPU hog in the box. It is
a known problem that seems to have been corrected in OO 1.1.0-RC3. Note
I am talking about the symptom, not about the cause of your overall
system slowness.

Regards,

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test4-mm1)
