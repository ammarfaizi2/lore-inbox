Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbTDNNNc (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbTDNNNc (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:13:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41145
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262996AbTDNNNa (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 09:13:30 -0400
Subject: Re: Linux on Unisys Aquanta HR/6 ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.44.0304141114040.12734-100000@math.ut.ee>
References: <Pine.GSO.4.44.0304141114040.12734-100000@math.ut.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050323228.25353.46.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Apr 2003 13:27:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-14 at 09:20, Meelis Roos wrote:
> Has anyone had any sucess running Linux on Unisys Aquanta HR/6 (or HR/6U
> if that matters)? This is a up to 6-way PPro SMP machine,
> http://www.unimetrix.com/hr6.html is the best description I have.

I can't help thinking a single AMD duron would outrun it. 

For Linux support the big thing you need to know is if the system
is "Intel MP 1.1/1.4 compliant".  A lot of the ppro boxes were,
but 6 ways can be a bit strange (the ALR 6x6 does work )

