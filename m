Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVCNPx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVCNPx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVCNPx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:53:28 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:37136 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261553AbVCNPxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:53:14 -0500
Date: Mon, 14 Mar 2005 10:52:55 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Greg Stark <gsstark@mit.edu>
Cc: Andrew Morton <akpm@osdl.org>, s0348365@sms.ed.ac.uk,
       linux-kernel@vger.kernel.org, pmcfarland@downeast.net
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
Message-ID: <20050314155253.GA8197@tuxdriver.com>
Mail-Followup-To: Greg Stark <gsstark@mit.edu>,
	Andrew Morton <akpm@osdl.org>, s0348365@sms.ed.ac.uk,
	linux-kernel@vger.kernel.org, pmcfarland@downeast.net
References: <200503130152.52342.pmcfarland@downeast.net> <874qff89ob.fsf@stark.xeocode.com> <200503140103.55354.s0348365@sms.ed.ac.uk> <87sm2y7uon.fsf@stark.xeocode.com> <20050313200753.20411bdb.akpm@osdl.org> <87br9m7s8h.fsf@stark.xeocode.com> <87zmx66b2b.fsf@stark.xeocode.com> <87u0nevc11.fsf@stark.xeocode.com> <20050314015321.5e944d84.akpm@osdl.org> <87is3uutg4.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87is3uutg4.fsf@stark.xeocode.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 10:40:27AM -0500, Greg Stark wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Herbert tells me that this might be fixed in 2.6.11.  Did you try that?
> 
> Nope. I'll try that. 
> 
> 
> (Though I'm skeptical. It went from 2.6.6 to 2.6.10 without being noticed but
> now it's fixed without any reports?)

(Presuming that the Quake3 problem is the same as the Wolfenstein:
ET problem...)

It was reported as a problem with RHEL3.  When I discovered the fix,
I pushed it to the OSS drivers in 2.6.x as well.

John
-- 
John W. Linville
linville@tuxdriver.com
