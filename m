Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTEBEfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 00:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbTEBEfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 00:35:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21979 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261338AbTEBEfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 00:35:53 -0400
Message-ID: <3EB1F886.3000106@pobox.com>
Date: Fri, 02 May 2003 00:48:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: azarah@gentoo.org
CC: KML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OSS support for ICH5 sound
References: <1051823687.11068.11.camel@nosferatu.lan>
In-Reply-To: <1051823687.11068.11.camel@nosferatu.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:
> Hi
> 
> I basically just added the ID's for the ICH5 sound, and it seems
> to be working fine here.  This is against bk7, I haven't had time
> to verify with bk11 yet, sorry.


Unfortunately this doesn't work on all ICH5s out there.  At the very 
minimum, for now, it would be nice to match up ich5 and codec pairs, as 
codec differentiation seems to be what stops this patch from working on 
all ICH5.

	Jeff



