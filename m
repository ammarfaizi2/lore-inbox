Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbUCRVya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbUCRVya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:54:30 -0500
Received: from [212.28.208.94] ([212.28.208.94]:63494 "HELO dewire.com")
	by vger.kernel.org with SMTP id S262983AbUCRVy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:54:26 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: RANDAZZO@ddc-web.com
Subject: Re: 2 nics in the same machine...
Date: Thu, 18 Mar 2004 22:54:22 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
References: <89760D3F308BD41183B000508BAFAC4104B17010@DDCNYNTD>
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B17010@DDCNYNTD>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403182254.22969.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 March 2004 21:20, RANDAZZO@ddc-web.com wrote:
> I have connected two nics in the same machine with a null modem cable...
> I have configured nic 1 to be 156.15.16.1 and nic 2 to be 156.15.16.2
> I have adjusted the routes so that nic 1 routes to nic 2 and vice versa...
> how come when I ping 156.15.16.1 it does not go out nic 2...
> am I missing something?

Yes. The ping packet is already at it's destination.

-- robin
