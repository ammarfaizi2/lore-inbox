Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbVKISvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbVKISvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbVKISvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:51:37 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:25074 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1751529AbVKISvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:51:37 -0500
Message-ID: <4372453C.5090508@mvista.com>
Date: Wed, 09 Nov 2005 10:51:40 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Beulich <JBeulich@novell.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/39] NLKD - time adjustment
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <43720F5E.76F0.0078.0@novell.com> <43720F95.76F0.0078.0@novell.com> <43720FBA.76F0.0078.0@novell.com> <43720FF6.76F0.0078.0@novell.com> <43721024.76F0.0078.0@novell.com> <4372105B.76F0.0078.0@novell.com>
In-Reply-To: <4372105B.76F0.0078.0@novell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Beulich wrote:
> Generic part of an interface to allow debuggers to update time after
> having halted the system for perhaps extended periods of time. This
> generally requires arch-dependent changes, too, unless the arch-
> dependent time handling is already overflow-safe.
> 
> Signed-Off-By: Jan Beulich <jbeulich@novell.com>
> 
> (actual patch attached)

Perhaps you could teach your mailer how to attach the atachments so that they appear inline to the 
reader.  The problem appears to be that it does not recognize the file type.  This is what it says:

Content-Type: application/octet-stream; name="linux-2.6.14-nlkd-time.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-nlkd-time.patch"

where as a correct attachment might look something like:

Content-Type: text/x-diff;
   charset="us-ascii";
   name="patch_x86_64-kernel-i8259"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch_x86_64-kernel-i8259"

This would allow us to comment on the patch with said comments appearing in the body of the patch.

> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
