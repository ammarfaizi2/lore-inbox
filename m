Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWDVAMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWDVAMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 20:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWDVAMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 20:12:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44998 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750780AbWDVAMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 20:12:49 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: linux-audit@redhat.com
Subject: Re: [RFC][PATCH 9/11] security: AppArmor - Audit changes
Date: Fri, 21 Apr 2006 20:13:52 -0400
User-Agent: KMail/1.7.2
Cc: Amy Griffis <amy.griffis@hp.com>, Tony Jones <tonyj@suse.de>,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175018.29149.391.sendpatchset@ermintrude.int.wirex.com> <20060421212109.GB1903@zk3.dec.com>
In-Reply-To: <20060421212109.GB1903@zk3.dec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604212013.52374.sgrubb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 17:21, Amy Griffis wrote:
> linux-audit (cc'd) will likely want to review these changes.

Yes, I second that. Tony, please cc audit patches to linux-audit mail list so 
we can see them. That said, I did tell Tony they could use message type 
numbers 1500 - 1600 for AppArmor if they need it.

-Steve
