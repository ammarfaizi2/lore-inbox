Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTE3Jqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 05:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTE3Jqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 05:46:39 -0400
Received: from [62.29.76.200] ([62.29.76.200]:17541 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S263496AbTE3Jqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 05:46:38 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Christoph Hellwig <hch@lst.de>
Subject: Re: Recent binutils releases and linux kernel 2.5.69+
Date: Fri, 30 May 2003 12:59:10 +0300
User-Agent: KMail/1.5.9
Cc: "H. J. Lu" <hjl@lucon.org>, linux kernel <linux-kernel@vger.kernel.org>,
       GNU C Library <libc-alpha@sources.redhat.com>
References: <20030529074448.A29931@lucon.org> <200305301245.26808.kde@myrealbox.com> <20030530094805.GA30793@lst.de>
In-Reply-To: <20030530094805.GA30793@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305301259.10457.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 May 2003 12:48, Christoph Hellwig wrote:
> How so?  If the sysctl values change you're screwed anyway.
Heh that was what I mean like what if glibc header and kernel header differs a 
lot. Its bringing more harm than goodness but including linux/sysctl.h in 
sys/sysctl.h makes two header synchronised.

Wondering what glibc guys think to solve this ? Ulrich Drepper or some other 
glibc hacker make a comment please?

Regards,
/ismail
