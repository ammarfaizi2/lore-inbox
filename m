Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbTIDWNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbTIDWLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:11:25 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:62736 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S265601AbTIDWK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:10:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: jimwclark@ntlworld.com, Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Date: Fri, 5 Sep 2003 01:10:50 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <1062637356.846.3471.camel@cube> <20030904202707.GF13676@matchmail.com> <200309042216.03958.jimwclark@ntlworld.com>
In-Reply-To: <200309042216.03958.jimwclark@ntlworld.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309050110.50236.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 00:16, James Clark wrote:
> I agree that at first sight the two concepts (Binary 'plugins' and GPL)
> don't mix well but this is actually FUD which obscures the issue of making
> the kernel much easier to deal with for the masses. Like it or not, 99+% of
> 'potential users' don't want/need to recompile their whole kernel, with the
> risks that it has, to add one minor feature.

Those 99+% are going to use a distro. A popular Linux distro
is a rough equivalent of a Windows install disk in terms of
ease of use, feature set and intended audience.
Distro can handle this problem (of driver ABI or absence thereof)
in any way it wants. I can imagine it can even go to the great pains
and introduce binary driver ABI. But unlikely.

OTOH I believe core kernel folks will not accept your proposal.
Stay a bit longer on lkml and you will understand why.
--
vda
