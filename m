Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTDLPci (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 11:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTDLPci (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 11:32:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34987
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263319AbTDLPch (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 11:32:37 -0400
Subject: Re: [ANNOUNCE] udev 0.1 release
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Dake <sdake@mvista.com>
Cc: Greg KH <greg@kroah.com>, "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       message-bus-list@redhat.com
In-Reply-To: <3E9741FD.4080007@mvista.com>
References: <20030411172011.GA1821@kroah.com>
	 <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk>
	 <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net>
	 <3E9725C5.3090503@mvista.com> <20030411204329.GT1821@kroah.com>
	 <3E9741FD.4080007@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050158747.16011.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Apr 2003 15:45:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-11 at 23:30, Steven Dake wrote:
> There is no "spec" that states this is a requirement, however, telecom 
> customers require the elapsed time from the time they request the disk 
> to be used, to the disk being usable by the operating system to be 20 msec.

That will be amusing. It takes 30 seconds for an IDE disk to go from
poweroff to online.  If its decided to have a quick powersaving nap
it'll take you longer than that too


