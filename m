Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTFOT2q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 15:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTFOT2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 15:28:46 -0400
Received: from [62.29.68.110] ([62.29.68.110]:55432 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S262763AbTFOT2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 15:28:45 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: fire-eyes <sgtphou@fire-eyes.dynup.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 / 2.5.71 - Problem at Uncompressing Linux... OK
Date: Sun, 15 Jun 2003 22:38:28 +0300
User-Agent: KMail/1.5.9
References: <1055704091.10275.22.camel@fire-eyes>
In-Reply-To: <1055704091.10275.22.camel@fire-eyes>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200306152238.28223.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 June 2003 22:08, fire-eyes wrote:
> I am just beginning to experiment with 2.5, my appologies if I have
> missed something. If there are other resources that could have answered
> this question, I eagerly await suggestions.
>
> With both 2.5.70 and 2.5.71, when the machine boots, it gets to
> "Uncompressing Linux... OK", and then it stops there. Disk activity is
> clearly still going on. After a short time, I can ping it, or other
> network activity. If I try to ssh into it, I am asked my password. After
> hitting enter, nothing happens. I can try this repeatedly to no avail.

Forgot to compile in framebuffer support yet you use vga=xxx in lilo.conf/grub 
config file ?

Regards,
/ismail 
