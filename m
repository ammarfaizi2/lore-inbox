Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTFYJBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 05:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTFYJBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 05:01:42 -0400
Received: from [194.151.80.102] ([194.151.80.102]:1335 "EHLO devwks01")
	by vger.kernel.org with ESMTP id S264219AbTFYJBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 05:01:41 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Semler Michal <cijoml@abclinuxu.cz>
Subject: Re: hda: dma_timer_expiry: dma status == 0x24
Date: Wed, 25 Jun 2003 11:27:49 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0306251103510.6750-200000@ABicko.abclinuxu.cz>
In-Reply-To: <Pine.LNX.4.44.0306251103510.6750-200000@ABicko.abclinuxu.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306251127.49194.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 June 2003 11:05, Semler Michal wrote:
> Yes.
>
> DMESG included
>
> CIJOML
>
> On Wed, 25 Jun 2003, Duncan Sands wrote:
> > UP with APIC?
> >
> > Duncan.

Try turning off the APIC or use the latest -ac kernel.

Duncan.
