Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTJ2ONy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 09:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbTJ2ONy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 09:13:54 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:42644 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S261345AbTJ2ONx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 09:13:53 -0500
Message-ID: <3F9FCB1F.9080606@mcve.com>
Date: Wed, 29 Oct 2003 09:13:51 -0500
From: Brad House <brad@mcve.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ross.alexander@uk.neceur.com
Cc: Brad House <brad_mssw@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: nforce2 stability on 2.6.0-test5 and 2.6.0-test9
References: <OF5F77CBA2.09E02070-ON80256DCE.00413294-80256DCE.0041A702@uk.neceur.com>
In-Reply-To: <OF5F77CBA2.09E02070-ON80256DCE.00413294-80256DCE.0041A702@uk.neceur.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, interesting. The patches I submitted were strictly
for IDE/ATA133 improvements, apparently your problems don't
lie there.  I'd assume this was a kernel panic you had, any
output available that would tell you where it paniced ?

-Brad

ross.alexander@uk.neceur.com wrote:
> Brad,
> 
> I'm running an ASUS A7N8X Deluxe mobo (nforce2 chipset) and still
> getting hardlockups.  I applied your patch but my system still locked
> up after about a day.  However 2.6.0-test5 seems to be stable.  I have
> had my system up for over three weeks with APIC and ACPI turned on.
> 
> Just to let you know,
> 
> Ross
> 
> ---------------------------------------------------------------------------------
> Ross Alexander                           "We demand clearly defined
> MIS - NEC Europe Limited            boundaries of uncertainty and
> Work ph: +44 20 8752 3394         doubt."
> 


