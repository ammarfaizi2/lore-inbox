Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264842AbTE1TPG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264841AbTE1TPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:15:05 -0400
Received: from [62.29.84.157] ([62.29.84.157]:65152 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S264839AbTE1TPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:15:02 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.5.70
Date: Wed, 28 May 2003 22:22:42 +0300
User-Agent: KMail/1.5.9
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305280909550.8790-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305280909550.8790-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305282222.42227.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 May 2003 19:14, Linus Torvalds wrote:
> On Wed, 28 May 2003, Bill Davidsen wrote:
> > Just the other day you posted strong opposition to breaking existing
> > binaries, how does that map with breaking existing hardware?
>
> One fundamental difference is that I cannot fix it without people who
> _have_ the hardware caring. So if they don't care, I don't care. It's that
> easy. If you want to have your hardware supported, you need to help
> support it.

Quite true. But there are bugs at kernel bugzilla which

1- People care about it being fixed
2- Tests beta kernels to see if its fixed
3- Reports success/failures

But still these bugs are unresolved. I do not say/mean kernel hackers do not 
care them or something like that but it would be better to get these kind of 
bugs ( with user base who tests them ) fixed before pre-2.6 releases.

Regards,
/ismail
