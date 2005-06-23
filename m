Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVFWU7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVFWU7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVFWU5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:57:53 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:28546 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262769AbVFWU4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 16:56:07 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Ed Sweetman <safemode@comcast.net>
Subject: Re: 2.6.12 breaks 8139cp
Date: Thu, 23 Jun 2005 14:55:23 -0600
User-Agent: KMail/1.8.1
Cc: Roberto Oppedisano <roppedisano.oppedisano@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
References: <42B9D21F.7040908@drzeus.cx> <200506231200.43671.bjorn.helgaas@hp.com> <42BB1DBD.5060808@comcast.net>
In-Reply-To: <42BB1DBD.5060808@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506231455.23997.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 June 2005 2:38 pm, Ed Sweetman wrote:
> I'm tempted to go ahead and try 2.6.11, but haven't yet.

Please do.  If 2.6.11 works and you have any VIA devices,
please also try the 2.6.12 patch from earlier in the thread
and see whether that helps.

Thanks!
