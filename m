Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUFLHli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUFLHli (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 03:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUFLHli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 03:41:38 -0400
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:55942 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261914AbUFLHlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 03:41:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Pokey the Penguin" <pokey@linuxmail.org>
Subject: Re: [ANNOUNCE] -ar patchset
Date: Sat, 12 Jun 2004 17:40:38 +1000
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, "Andrew Rodland" <arodland@entermail.net>
References: <20040612023928.A103F23C03@ws5-3.us4.outblaze.com>
In-Reply-To: <20040612023928.A103F23C03@ws5-3.us4.outblaze.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406121740.39009.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2004 12:39, Pokey the Penguin wrote:
> > find the initial version of the patch, with staircase,
> > autoregulate-swappiness, supermount-ng, ext3 and reiser improvements, and
> > a
>
> I gather that supermount-ng is now quite dated and no longer maintained. Is
> submount (http://submount.sourceforge.net/) not the current favourite to
> provide such functionality?
>
> Looking at the two, submount definitely seems more ready for inclusion
> based on its non-invasive approach.

Because supermount-ng is what our users want it to be:
It's stable, mature and fully functional without any userspace changes (apart 
from the fstab entry) and thousands of people use it daily without any 
problems. Whether you (or the mainline kernel maintainers) like the patch or 
not is a different matter. I've been porting it to each main release version.

Con
