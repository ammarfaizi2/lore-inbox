Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUIAPFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUIAPFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUIAPFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:05:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1204 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266820AbUIAPFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:05:00 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: linux-cluster@redhat.com, sdake@mvista.com
Subject: Re: [Linux-cluster] New virtual synchrony API for the kernel: was Re: [Openais] New API in openais
Date: Wed, 1 Sep 2004 11:06:00 -0400
User-Agent: KMail/1.6.2
Cc: John Cherry <cherry@osdl.org>, openais@lists.osdl.org,
       linux-kernel@vger.kernel.org, linux-ha-dev@new.community.tummy.com
References: <1093941076.3613.14.camel@persist.az.mvista.com> <1093973757.5933.56.camel@cherrybomb.pdx.osdl.net> <1093981842.3613.42.camel@persist.az.mvista.com>
In-Reply-To: <1093981842.3613.42.camel@persist.az.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409011106.00541.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Tuesday 31 August 2004 15:50, Steven Dake wrote:
> It would be useful for linux cluster developers for a common low
> level group communication API to be agreed upon by relevant clusters
> projects.  Without this approach, we may end up with several systems
> all using different cluster communication & membership mechanisms
> that are incompatible.

To be honest, this does look interesting, however could you help me on a 
few points:

  - Is there any evil IP we have to worry about with this?

  - Can I get a formal interface spec from AIS for this, without
    signing a license?

  - Have you got benchmarks available for control and normal messaging

  
