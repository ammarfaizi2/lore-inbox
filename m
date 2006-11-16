Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424254AbWKPQO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424254AbWKPQO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 11:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424256AbWKPQO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 11:14:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:54840 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1424254AbWKPQO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 11:14:28 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,430,1157353200"; 
   d="scan'208"; a="16630227:sNHT22806315"
Message-ID: <455C8E32.10406@intel.com>
Date: Thu, 16 Nov 2006 08:13:38 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Oleg Verych <olecom@flower.upol.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: git web (Re: nightly 2.6 LXR run?)
References: <1163530480.16381.23.camel@jcm.boston.redhat.com> <slrnelkj1s.7lr.olecom@flower.upol.cz> <455A4EF8.5030004@foo-projects.org> <20061116093636.GA19002@flower.upol.cz>
In-Reply-To: <20061116093636.GA19002@flower.upol.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Nov 2006 16:13:38.0881 (UTC) FILETIME=[2D0D5310:01C7099A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Verych wrote:
> On Tue, Nov 14, 2006 at 03:19:20PM -0800, Auke Kok wrote:
> []
>> try to use `git2.kernel.org` instead of `git.kernel.org`. The second server 
>> somehow only has an average load of ~4 instead of ~250.
> 
> Looking closer, i see all gitweb links (C) on both servers links are poining
> to "www.kernel.org/git/?...". So, i thing there's no gitweb dup, only file
> storage mirror.
> 
> BTW
> ,--
> |olecom@flower:~$ host git.kernel.org
> |git.kernel.org          CNAME   zeus-pub.kernel.org
> |zeus-pub.kernel.org     A       204.152.191.37
> |olecom@flower:~$ host git2.kernel.org
> |git2.kernel.org         CNAME   zeus-pub2.kernel.org
> |zeus-pub2.kernel.org    A       204.152.191.37
> |olecom@flower:~$
> `--
> (maybe it's some way of multiplexing...)
> 
> And still "The load average on the server is too high".

zeus1 is apparently offline due to a fan failure, so someone is playing mind tricks on 
you with DNS

Auke


