Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTFAIXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 04:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTFAIXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 04:23:42 -0400
Received: from [62.29.65.73] ([62.29.65.73]:10368 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S261741AbTFAIXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 04:23:41 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: "Kevin P. Fleming" <kpfleming@cox.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/sysctl.h needs linux/compiler.h
Date: Sun, 1 Jun 2003 11:36:27 +0300
User-Agent: KMail/1.5.9
References: <3ED8D5E4.6030107@cox.net> <200306010016.05548.kde@myrealbox.com> <3ED93CC6.30200@cox.net>
In-Reply-To: <3ED93CC6.30200@cox.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200306011136.27211.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 June 2003 02:37, Kevin P. Fleming wrote:
> Oh, I saw that discussion. I fully agree. If I can help the process of
> creating a sanitized userspace set of kernel headers I'll be happy to.
>
> In the meantime, a small change to a kernel header, that provides _zero_
> functional difference to the kernel itself (it's only there for source
> code checkers, as best I can tell) shouldn't break existing userspace
> libraries.
Fully ACK.

Regards,
/ismail
