Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130497AbRCLRZf>; Mon, 12 Mar 2001 12:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130502AbRCLRZ0>; Mon, 12 Mar 2001 12:25:26 -0500
Received: from darkstar.internet-factory.de ([195.122.142.9]:24450 "EHLO
	darkstar.internet-factory.de") by vger.kernel.org with ESMTP
	id <S130497AbRCLRZO>; Mon, 12 Mar 2001 12:25:14 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: Linux 2.4.2ac18
Date: Mon, 12 Mar 2001 18:24:46 +0100
Organization: Internet Factory AG
Message-ID: <3AAD065E.FC34E8F3@internet-factory.de>
In-Reply-To: <3AACFB8B.B8F6D93B@internet-factory.de> <E14cVZB-0002DC-00@the-village.bc.nu>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 984417886 11213 195.122.142.158 (12 Mar 2001 17:24:46 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 12 Mar 2001 17:24:46 GMT
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac16 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > [overclocked CPU detection code]
> It doesnt work usefully. The bit we really needed (clock multiplier reading)
> does work so its a case of one won lost one

But this won't catch FSB overclocking at all (which nowadays seems the
most common way of oc-ing, since it does not involve any modifications
to the CPU other than maybe a better cooler). Or am I missing something?
And what exactly does the multiplier reading alone buy us? (No offense
meant - I am just curious because I really liked the feature, did not
even know that it was possible, and am a bit sad to see it go again)

Holger
