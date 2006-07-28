Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161288AbWG1Ucn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161288AbWG1Ucn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161287AbWG1Ucn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:32:43 -0400
Received: from mga05.intel.com ([192.55.52.89]:60827 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161288AbWG1Ucm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:32:42 -0400
X-IronPort-AV: i="4.07,193,1151910000"; 
   d="scan'208"; a="106776973:sNHT14658315"
Message-ID: <44CA7450.6090203@linux.intel.com>
Date: Fri, 28 Jul 2006 22:32:16 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 1/5] Add comments to the PDA structure to annotate offsets
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <200607282041.38506.ak@suse.de> <1154112207.6416.44.camel@laptopd505.fenrus.org> <200607282052.20559.ak@suse.de>
In-Reply-To: <200607282052.20559.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> that is 
>> documented in the later patch
> 
> I still hate the numbers. Perhaps do them only before your canary.

that's what the patch does

> Also you should have a BUILD_BUG_ON() for this somewhere

fair enough
