Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWAWUoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWAWUoH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWAWUnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:43:52 -0500
Received: from free.wgops.com ([69.51.116.66]:41743 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S964941AbWAWUnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:43:21 -0500
Date: Mon, 23 Jan 2006 13:43:00 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <280A351A008C409CEF43A734@dhcp-2-206.wgops.com>
In-Reply-To: <728201270601230705k25e6890ejd716dbfc393208b8@mail.gmail.com>
References: <200601212108.41269.a1426z@gawab.com>	
 <986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>	
 <E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
 <728201270601230705k25e6890ejd716dbfc393208b8@mail.gmail.com>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 23, 2006 9:05:41 AM -0600 Ram Gupta <ram.gupta5@gmail.com> 
wrote:

>
> Linux also supports multiple swap files . But these are more
> beneficial if there are more than one disk in the system so that i/o
> can be done in parallel. These swap files may be activated at run time
> based on some criteria.

You missed the point.  The kernel in OS X maintains creation and use of 
these files automatically.  The point wasn't oh wow multiple files' it was 
that it creates them on the fly.  I just posted back with the apparent new 
method that's being used.  I'm not sure if the 512MB number continues or if 
the next file will be 1Gb or another 512M.  Or of memory size affects it or 
not.

I'm sure developer.apple.com or apple darwin pages have the information 
somewhere.
