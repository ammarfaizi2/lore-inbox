Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266791AbUFRUCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266791AbUFRUCV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266764AbUFRT75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:59:57 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:40372 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S266588AbUFRT41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:56:27 -0400
Date: Fri, 18 Jun 2004 20:56:03 +0100
From: Ian Molton <spyro@f2s.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-Id: <20040618205603.07f8fc56.spyro@f2s.com>
In-Reply-To: <1087587004.2078.137.camel@mulgrave>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.com>
	<1087587004.2078.137.camel@mulgrave>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2004 14:30:01 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> Is your problem that you'd like the dma pools it uses to come out of the
> on chip buffer?

Correct. its the right way to do this.
