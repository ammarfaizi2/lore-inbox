Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUAMKJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 05:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUAMKJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 05:09:40 -0500
Received: from hydrogen.customer.frii.com ([216.17.138.219]:8723 "EHLO
	hydrogen.imeme.net") by vger.kernel.org with ESMTP id S264155AbUAMKJj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 05:09:39 -0500
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Reply-To: gj@pointblue.com.pl
To: Andre Tomt <andre@tomt.net>
Subject: Re: 2.4.24+grsec compilation issue
Date: Tue, 13 Jan 2004 10:09:30 +0000
User-Agent: KMail/1.5.94
References: <200401122142.06931.gj@pointblue.com.pl> <4003611D.1020105@tomt.net>
In-Reply-To: <4003611D.1020105@tomt.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Organization: K4 labs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401131009.30858.gj@pointblue.com.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 January 2004 03:08, you wrote:
> This does not belong on this list unless you get the same problem with a
> clean vanilla kernel.

Don't think so.

Anyway, it looks like bug in debian stable binutils/gcc. Well, I forgot to 
mention that it was woody. It does recompile fine on unstable.

-- 
Grzegorz Jaskiewicz
K4 labs
