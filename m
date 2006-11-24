Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755096AbWKXKyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbWKXKyn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 05:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756545AbWKXKyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 05:54:43 -0500
Received: from mail.axxeo.de ([82.100.226.146]:176 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1755095AbWKXKym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 05:54:42 -0500
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Make udp_encap_rcv use pskb_may_pull
Date: Fri, 24 Nov 2006 11:54:15 +0100
User-Agent: KMail/1.9.1
Cc: okir@suse.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20061123000144.GB7452@suse.de> <20061122.201136.129449260.davem@davemloft.net>
In-Reply-To: <20061122.201136.129449260.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611241154.15740.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Miller wrote:
> From: Olaf Kirch <okir@suse.de>
> Date: Thu, 23 Nov 2006 01:01:44 +0100
> 
> > 
> > Make udp_encap_rcv use pskb_may_pull
> 
> Excellent catch, applied, thanks Olaf.

Should this go to -stable, too? Or are these kernels not affected, yet?

Regards

Ingo Oeser
