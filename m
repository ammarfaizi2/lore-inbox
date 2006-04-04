Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWDDLOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWDDLOH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 07:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWDDLOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 07:14:06 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43967 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751853AbWDDLOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 07:14:05 -0400
Message-ID: <443254E3.3010203@sgi.com>
Date: Tue, 04 Apr 2006 13:13:39 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060223)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, bjorn_helgaas@hp.com,
       cotte@de.ibm.com
Subject: Re: [patch] msepc driver (requires do_no_pfn)
References: <yq0fykuuc3h.fsf@jaguar.mkp.net> <Pine.LNX.4.61.0604032015380.18399@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604032015380.18399@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> +config MSPEC
>> +	tristate "  Memory special operations driver"
> 
> The two blanks after " are not needed anymore with the new Kconfig 
> from 2.6.x.

Hi Jan,

You're right. I updated my patch here, next version will have it right.
Lets see what happens to the nopfn stuff first.

Thanks,
Jes
