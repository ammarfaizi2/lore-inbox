Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUC1QRp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 11:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUC1QRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 11:17:45 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:58121 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261933AbUC1QRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 11:17:44 -0500
Date: Sun, 28 Mar 2004 20:17:19 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: status of Linux on Alpha?
Message-ID: <20040328201719.A14868@jurassic.park.msu.ru>
References: <yw1xsmftnons.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <yw1xsmftnons.fsf@ford.guide>; from mru@kth.se on Sun, Mar 28, 2004 at 02:26:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 02:26:15PM +0200, Måns Rullgård wrote:
> There was a thread a while ago about some odd problems with 2.6.4 on
> Alpha.  Were those problems ever resolved?

No idea. I wasn't able to reproduce them. Perhaps it has something
to do with particular drivers (raid, XFS or something else).

> Is anything past 2.6.3 stable on Alpha?

There was nothing special about 2.6.4. Those problems must be present
in 2.6.3 and earlier kernels as well.

Ivan.
