Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWBXIec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWBXIec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 03:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWBXIec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 03:34:32 -0500
Received: from mta-gw2.infomaniak.ch ([84.16.68.87]:50111 "EHLO
	mta-gw2.infomaniak.ch") by vger.kernel.org with ESMTP
	id S932109AbWBXIec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 03:34:32 -0500
In-Reply-To: <20060224025759.GA14027@redhat.com>
References: <200601050223.k052Ngu2003866@hera.kernel.org> <20060224025759.GA14027@redhat.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <43D870D4-441C-4B85-AEA9-BB08C5079C4D@brownhat.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, jreiser@BitWagon.com
Content-Transfer-Encoding: 7bit
From: Daniele Venzano <venza@brownhat.org>
Subject: Re: [PATCH] Add Wake on LAN support to sis900 (2)
Date: Fri, 24 Feb 2006 09:34:08 +0100
To: Dave Jones <davej@redhat.com>
X-Mailer: Apple Mail (2.746.2)
X-Antivirus: Dr.Web (R) for Mail Servers on mta-spa2 host
X-Antivirus-Code: 100000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno 24/feb/06, alle ore 03:57, Dave Jones ha scritto:

> The patch below applied on Jan 5th causes some systems to no longer  
> boot.
> See https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=179601
> for details.
I'm aware of the problem (found by Lennert Buytenhek, bugzilla:  
5977). Obviously the patch I made was lost or I just forgot to send  
it away. In a few minutes I hope to send the patch, I have to check  
that it still applies.

Thanks.
--
Daniele Venzano
http://www.brownhat.org

