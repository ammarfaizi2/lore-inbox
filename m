Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbTFXORI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 10:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFXORI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 10:17:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26800 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262090AbTFXORF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 10:17:05 -0400
Message-ID: <3EF860A7.5000102@pobox.com>
Date: Tue, 24 Jun 2003 10:31:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Stephan von Krawczynski <skraw@ithnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Broadcom bcm 4401
References: <20030623151040.135133f9.skraw@ithnet.com> <1056377068.13529.41.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1056377068.13529.41.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2003-06-23 at 14:10, Stephan von Krawczynski wrote:
> 
>>Hello all,
>>
>>does anybody know what drivers are available for BCM4401 network cards? Are
>>they somehow compatible to whatever?
> 
> 
> There is a broadcom b44 driver in -ac, but it needs a lot more cleaning
> up or rewriting before it goes anywhere further


What cleaning needs to be done?

AFAIK, I need only to fix a phy-related bug, and b44 will be working 
nicely.  (I have test h/w, too)

	Jeff



