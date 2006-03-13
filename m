Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbWCMRDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWCMRDj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 12:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbWCMRDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 12:03:39 -0500
Received: from fmr17.intel.com ([134.134.136.16]:64143 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751676AbWCMRDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 12:03:38 -0500
Message-ID: <4415A586.1010404@linux.intel.com>
Date: Mon, 13 Mar 2006 18:01:58 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Antonino Daplas <adaplas@pol.net>, Andi Kleen <ak@suse.de>
Subject: Re: [patch] Require VM86 with VESA framebuffer
References: <200603131159_MC3-1-BA89-78CA@compuserve.com>
In-Reply-To: <200603131159_MC3-1-BA89-78CA@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <1142261096.25773.19.camel@localhost.localdomain>
> References: <1142261096.25773.19.camel@localhost.localdomain>
> 
> On Mon, 13 Mar 2006 14:44:56 +0000, Alan Cox wrote:
> 
> 
>> VESA does not require VM86 so this change is completely wrong.
> 
> What is this all about then?
> 
that is about X requiring it. Not about anything kernel related.
