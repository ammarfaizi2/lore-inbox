Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266374AbUAVWOS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 17:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266395AbUAVWOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 17:14:18 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:37881 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S266374AbUAVWOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 17:14:17 -0500
Date: Thu, 22 Jan 2004 14:14:08 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Nicklas Bondesson <nicke@nicke.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATARAID (replacement) in 2.6.x
Message-ID: <20040122221408.GU23765@srv-lnx2600.matchmail.com>
Mail-Followup-To: Nicklas Bondesson <nicke@nicke.nu>,
	linux-kernel@vger.kernel.org
References: <S266189AbUAVWIY/20040122220824Z+36009@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S266189AbUAVWIY/20040122220824Z+36009@vger.kernel.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 11:08:25PM +0100, Nicklas Bondesson wrote:
> I wonder what the status is on implementing an ataraid (replacement) in the
> 2.6.x kernel tree. It can be done with device mapping, but it's still far
> too tactless I think.

Many disagree.

In fact it looks like MD will be merged with DM, so you might as well start
on usind DM for this too.
