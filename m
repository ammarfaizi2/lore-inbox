Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTE2QJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTE2QJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:09:23 -0400
Received: from [62.29.80.16] ([62.29.80.16]:25472 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S262379AbTE2QJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:09:20 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Christoph Hellwig <hch@lst.de>, "H. J. Lu" <hjl@lucon.org>
Subject: Re: Recent binutils releases and linux kernel 2.5.69+
Date: Thu, 29 May 2003 19:21:47 +0300
User-Agent: KMail/1.5.9
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       GNU C Library <libc-alpha@sources.redhat.com>
References: <20030529074448.A29931@lucon.org> <20030529084948.A30796@lucon.org> <20030529160326.GB19751@lst.de>
In-Reply-To: <20030529160326.GB19751@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305291921.47154.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> On Thu, May 29, 2003 at 08:49:48AM -0700, H. J. Lu wrote:
> > This is a kernel issue and should be fixed in kernel unless we want
> > to do something in <sys/sysctl.h>.
>
> You should not include kernel headers from userspace.

Old story I know but I dont think binutils would use kernel headers if it 
doesnt need it.

Regards,
/ismail

P.S: Yeah I am voidcartman@yahoo.com
