Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbULSBzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbULSBzc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 20:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbULSBzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 20:55:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35770 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261260AbULSBz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 20:55:28 -0500
Message-ID: <41C4DF86.1090209@pobox.com>
Date: Sat, 18 Dec 2004 20:55:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: OOPS in 2.4.29-pre2
References: <41C43165.8010700@ribosome.natur.cuni.cz>
In-Reply-To: <41C43165.8010700@ribosome.natur.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin MOKREJ© wrote:
> Hi,
>  I'm testing 2.4.29-pre2 kernelon my ASUS L3800C laptop.
> I have already managed to get several, this is one of them.
> Please Cc: me in replies. Thanks.
> 
> 
> Unable to handle kernel paging request at virtual address 5a5a5a5a
> 5a5a5a5a

That looks like an artifact of "poisoning" (debugging) code.

What options under the debug menu do you have enabled?

	Jeff



