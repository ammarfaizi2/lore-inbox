Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUHSWAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUHSWAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUHSWAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:00:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23524 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267445AbUHSWAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:00:51 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Ray Bryant <raybry@sgi.com>
Subject: Re: kernbench on 512p
Date: Thu, 19 Aug 2004 18:00:41 -0400
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408191711.04776.jbarnes@engr.sgi.com> <4125208D.5070809@sgi.com>
In-Reply-To: <4125208D.5070809@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408191800.41995.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 19, 2004 5:50 pm, Ray Bryant wrote:
> Anyway, the read lock handling is sufficiently busticated that we should
> probably just remove it.  I have a patch someplace (years old) to fix this,
> but it never seemed to be important to anyone, so it is still unapplied.

It would be nice if you resurrected it and sent it along to Andrew.  He's had 
the lockmeter patch in his tree for awhile now, so having a good version 
there is probably a good idea.

Thanks,
Jesse
