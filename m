Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269797AbUH0BEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269797AbUH0BEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269863AbUH0BBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:01:05 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:6047 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269797AbUH0Awy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:52:54 -0400
Date: Thu, 26 Aug 2004 17:51:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>, Nuno Silva <nuno.silva@vgertech.com>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.9-rc1-mm1
Message-ID: <93300000.1093567895@flay>
In-Reply-To: <412E8475.5000505@kolivas.org>
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org> <200408261636.06857.rjw@sisk.pl> <412E11ED.7040300@kolivas.org> <52540000.1093553736@flay> <412E7004.3070503@kolivas.org> <412E824F.90704@vgertech.com> <412E8475.5000505@kolivas.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, August 27, 2004 10:46:45 +1000 Con Kolivas <kernel@kolivas.org> wrote:

> Nuno Silva wrote:
>> Con Kolivas wrote:
>>> If you're talking about using the embedded image viewer in kde, that 
>>> spins on wait and wastes truckloads of cpu (a perfect example of poor 
>>> coding). Try loading it an external viewer and it will be 1000 times 
>>> faster. If you're talking about it keeping the disk too busy on the 
>>> other hand, that's I/O scheduling.
>>> 
>> 
>> The question is: "can a poorly coded app hang the system for 30secs?"
>> 
>> That's a DoS ;-)
> 
> It does not hang the system, only it's dependant tasks (ie other kde thingies)

the display app (not KDE), however, at least seems to deny X of enough time 
that the mouse cursor won't move. Much badness! ;-)

M.

