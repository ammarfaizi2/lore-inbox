Return-Path: <linux-kernel-owner+w=401wt.eu-S1753770AbXABXzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbXABXzp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbXABXzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:55:45 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1512 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770AbXABXzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:55:44 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ppc: vio of_node_put cleanup
Date: Wed, 3 Jan 2007 00:57:08 +0100
User-Agent: KMail/1.9.5
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <200701021238.36297.m.kozlowski@tuxland.pl> <1220f3e52f791ff8871ca9328b027a5a@kernel.crashing.org>
In-Reply-To: <1220f3e52f791ff8871ca9328b027a5a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701030057.08957.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Segher, 

> The comment used to be inside the "if" block, is this
> change correct?

You'd prefer an empty line in there?

> [And, do we want all these changes anyway?  I don't care
> either way, both sides have their pros and their cons --
> just asking :-) ]

You know my opinion already :-)

-- 
Regards,

	Mariusz Kozlowski
