Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTE3JdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 05:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTE3JdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 05:33:05 -0400
Received: from [62.29.76.200] ([62.29.76.200]:1413 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S261906AbTE3JdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 05:33:04 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Christoph Hellwig <hch@lst.de>, "H. J. Lu" <hjl@lucon.org>
Subject: Re: Recent binutils releases and linux kernel 2.5.69+
Date: Fri, 30 May 2003 12:45:26 +0300
User-Agent: KMail/1.5.9
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       GNU C Library <libc-alpha@sources.redhat.com>
References: <20030529074448.A29931@lucon.org> <20030529095940.B31904@lucon.org> <20030530084824.GA29758@lst.de>
In-Reply-To: <20030530084824.GA29758@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305301245.26808.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 May 2003 11:48, Christoph Hellwig wrote:
> I know. and <linux/sysctl.h> is a kernel header libc shouldn't include.
> So you want to do something to <sys/sysctl.h>, namely get rid of it's
> depency on kernel headers.
Wouldn't this result in glibc-kernel inconsistency in headers?


Regards,
/ismail
