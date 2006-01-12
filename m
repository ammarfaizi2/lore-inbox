Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWALJi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWALJi6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWALJi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:38:58 -0500
Received: from relay01.pair.com ([209.68.5.15]:14348 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S964776AbWALJi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:38:57 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Eric Belhomme <{gmane}+no/spam@ricospirit.net>
Subject: Re: why sk98lin driver is not up-to date ?
Date: Thu, 12 Jan 2006 03:39:16 -0600
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <Xns97496767C8536ericbelhommefreefr@80.91.229.5>
In-Reply-To: <Xns97496767C8536ericbelhommefreefr@80.91.229.5>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120339.17071.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 03:09, Eric Belhomme wrote:
> So this archive is more recent than sources included in stock kernel, but
> older than 2.6.14 kernel, so I wonder why this revision of sk98lin is not
> included in kernel ?

Eric,
	IIRC, the SysKonnect official GPL driver attempts to support two different 
chipsets / possibly has other coding issues as well. I think this is the 
reason SysKonnect's driver is still out of tree. I think some netdev folks 
might be working on newer drivers, but I haven't been keeping track honestly.

Cheers,
Chase
