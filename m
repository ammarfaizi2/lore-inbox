Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266451AbUH0QO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUH0QO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUH0QO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:14:59 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:21145 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266451AbUH0QOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:14:30 -0400
Message-ID: <412F5DE1.1030204@nortelnetworks.com>
Date: Fri, 27 Aug 2004 12:14:25 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Andersen <anddan@linux-user.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-NEW] README - Explain new 2.6.xx.x bug-fix release numbering
 scheme
References: <412F52FA.5060904@linux-user.net>
In-Reply-To: <412F52FA.5060904@linux-user.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Andersen wrote:

> Feel free to comment and suggest changes to it, the whole point is to
> make it readable in a way that normal human beings can make some sense
> out of it. (Read: Your grandmother)

> +   As of kernel 2.6.8 there was a bug-fix release numbering scheme
> +   introduced. In such cases a fourth number is added to the release
> +   version, eg. 2.6.8.1. When patching from a 2.6.xx(.x) release to a
> +   newer version, patches are to be applied against the original
> +   release, eg. 2.6.8 and not the bug-fix release 2.6.8.1. 

Perhaps "When patching from 2.6.x.y to 2.6.x.(y+1), patches are to be applied 
against 2.6.x, not 2.6.x.y."

Chris
