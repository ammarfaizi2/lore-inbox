Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270219AbTGRLlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 07:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270222AbTGRLlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 07:41:05 -0400
Received: from lvs00-fl.valueweb.net ([216.219.253.199]:53387 "EHLO
	ams004.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S270219AbTGRLlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 07:41:03 -0400
Message-ID: <3F17DFDD.6040006@coyotegulch.com>
Date: Fri, 18 Jul 2003 07:54:05 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: typo bits
References: <Pine.GSO.4.21.0307181221390.22944-100000@vervain.sonytel.be> <1058528165.19558.3.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1058528165.19558.3.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>>- * It's now support isochronous mode and more effective than hc_sl811.o
>>>+ * It's now support isosynchronous mode and more effective than hc_sl811.o
>>
>>I thought the correct term was `isochronous'...
> 
> Perhaps someone can clarify - however isochornus is definitely wrong either way

"Isochronous" is correct; it is a synonym for "isochronal", which means 
"uniform in time; of equal duration". That is, I believe, apropos to the 
intended meaning of the comment above.

"Isosynchronous" does not appear in any of my dictionaries.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing

