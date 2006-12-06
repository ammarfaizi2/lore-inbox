Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760235AbWLFGKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760235AbWLFGKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760234AbWLFGKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:10:36 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:32990 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760231AbWLFGKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:10:34 -0500
Message-ID: <45765EC7.2000908@tw.ibm.com>
Date: Wed, 06 Dec 2006 14:10:15 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Oops in pata_pdc2027x
References: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
In-Reply-To: <20061205170144.0b98d7e6.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> Hi all,
> 
> I get an oops during initialisation of the pata_pdc2027x module on a
> POWER 285 machine.  This is on a very recent Linus kernel tree
> (ff51a98799931256b555446b2f5675db08de6229) with Paulus' powerpc tree
> (that has now been merged). The oops looks like this:
> 

Hi Stephen,

Where could I download the patched kernel source? There are two
POWER5 9110-51A boxes here. Maybe I could try to reproduce the problem
on these boxes.

--
albert


