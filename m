Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVANK1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVANK1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 05:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVANK1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 05:27:44 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:50446 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261937AbVANK1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 05:27:37 -0500
Message-ID: <41E7A088.4010708@hist.no>
Date: Fri, 14 Jan 2005 11:35:52 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: John covici <covici@ccs.covici.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
References: <41E64DAB.1010808@hist.no> <16870.21720.866418.326325@ccs.covici.com> <Pine.LNX.4.60.0501131820230.20576@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.60.0501131820230.20576@dlang.diginsite.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

> I ran into a similar problem with 2.6.8.1 and found that by 
> downgrading to AGP4 I could get it to work.

It can't be AGP because it is a PCI card.
Unless something is so broken as to mess with
AGP when dealing with a PCI card, that is.  I have an
AGP card too in this machine.

Helge Hafting
