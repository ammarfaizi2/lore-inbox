Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbTE2LBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 07:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTE2LBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 07:01:47 -0400
Received: from [62.29.86.9] ([62.29.86.9]:60800 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S262142AbTE2LBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 07:01:45 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Linux 2.5.70
Date: Thu, 29 May 2003 14:14:10 +0300
User-Agent: KMail/1.5.9
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305280909550.8790-100000@home.transmeta.com> <200305282222.42227.kde@myrealbox.com> <20030529111431.GA19994@suse.de>
In-Reply-To: <20030529111431.GA19994@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305291414.10443.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 May 2003 14:14, Dave Jones wrote:
> Quite a lot of the 'xxx driver does not compile' bugs in bugzilla
> may actually have been filed by people just doing coverage testing
> to see what actually compiles and what doesn't.
> This does unfortunatly make it harder to see at first glance which
> drivers are actually still being used by users. The fact that quite
> a few of them have no follow-ups does suggest however that no-one who
> actually has the hardware cares enough to keep pushing to get things
> fixed.  Moving a bunch of these under a CONFIG_BROKEN could be a useful
> thing to seperate the wheat from the chaff.

I was talking about bugs where user does provide valuable feedback not just 
this/that does not compile but more info,debugging,testing etc.

Regards,
/ismail
