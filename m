Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbTEOGIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 02:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263886AbTEOGIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 02:08:52 -0400
Received: from [62.29.80.127] ([62.29.80.127]:63105 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S263884AbTEOGIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 02:08:46 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Stephen Torri <storri@sbcglobal.net>
Subject: Re: Compile error including asm/uaccess.h
Date: Thu, 15 May 2003 08:57:20 +0300
User-Agent: KMail/1.5.9
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1052919428.273b9220kde@smtp-send.myrealbox.com> <1052921988.25317.3.camel@base>
In-Reply-To: <1052921988.25317.3.camel@base>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305150857.20566.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 May 2003 17:19, Stephen Torri wrote:
> How then do you wrote an application to utilize kernel features? I am
> working on a real-time operating system (KURT - www.ittc.ku.edu/kurt)
> and need to include a header that exists in the kernel. The header is
> installed in the /usr/src/linux/include/linux/ but not in
> /usr/include/linux.
>

See what definitions missing and typedef them in your own source code. That 
way you wont need other kernel headers.


-- 
Brain fried -- Core dumped 
