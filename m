Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTEaVDN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 17:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTEaVDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 17:03:13 -0400
Received: from [62.29.80.118] ([62.29.80.118]:42113 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S264450AbTEaVDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 17:03:12 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: "Kevin P. Fleming" <kpfleming@cox.net>
Subject: Re: [PATCH] include/linux/sysctl.h needs linux/compiler.h
Date: Sun, 1 Jun 2003 00:16:05 +0300
User-Agent: KMail/1.5.9
Cc: LKML <linux-kernel@vger.kernel.org>
References: <3ED8D5E4.6030107@cox.net> <200305312358.03208.kde@myrealbox.com> <3ED919DC.6030202@cox.net>
In-Reply-To: <3ED919DC.6030202@cox.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200306010016.05548.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 June 2003 00:08, Kevin P. Fleming wrote:

> Right. But until such time as that happens (even if started today that's
> many months away), real world libraries need to be compiled to be used
> against the new kernel.
>
Yes I reported to binutils hackers that this change broke binutils ( + glibc ) 
but kernel guys just say "do not include kernel headers in userspace" . 


Regards,
/ismail
