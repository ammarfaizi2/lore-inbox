Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVBXXZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVBXXZz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVBXXZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:25:54 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:19931 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262553AbVBXXZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:25:42 -0500
Message-ID: <421E6268.2060507@nortel.com>
Date: Thu, 24 Feb 2005 17:25:28 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nagar@watson.ibm.com
CC: Greg KH <greg@kroah.com>, Gerrit Huizenga <gh@us.ibm.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [PATCH] CKRM: 4/10 CKRM: Full rcfs support
References: <20041129221548.GD19892@kroah.com> <E1D4FN0-0006v2-00@w-gerrit.beaverton.ibm.com> <20050224174230.GA10244@kroah.com> <421E546F.4070505@watson.ibm.com>
In-Reply-To: <421E546F.4070505@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:

> Sounds like a case is being made to make CONFIG_RCFS a "y" and eliminate
> the possibility of it being a loadable module ?

No, I believe the idea was to make CONFIG_RCFS be automatically set to 
the same as CKRM.

Chris
