Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbUAOAI2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbUAOAI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:08:28 -0500
Received: from mrout1.yahoo.com ([216.145.54.171]:55309 "EHLO mrout1.yahoo.com")
	by vger.kernel.org with ESMTP id S264163AbUAOAI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:08:27 -0500
Message-ID: <4005D9E7.2070203@bigfoot.com>
Date: Wed, 14 Jan 2004 16:08:07 -0800
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.5) Gecko/20031111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org> <87hdyyxjgl.fsf@stark.xeocode.com> <20040114225653.GA32704@codepoet.org> <4005D195.3010008@inp-net.eu.org>
In-Reply-To: <4005D195.3010008@inp-net.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael Rigo wrote:
...<ICH5problems snipped>...
> One possible workaround it to enable both PATA and SATA drivers (using 
> libata) and pass "ide2=noprobe ide3=noprobe" to kernel at boot.
> More detailled answer can be found here : 
> http://www.hentges.net/howtos/p4p800_deluxe.html

   I have pretty much the same setup he recommends in UPDATE except of 
the "ide2=noprobe ide3=noprobe" kernel boot options, not sure why would 
that be needed but my system (interl D865PERL, cd burner, ide and sata 
disks) works OK without it.

	erik

