Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTFKUQc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTFKUQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:16:32 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:49597 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264197AbTFKUQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:16:30 -0400
Date: Wed, 11 Jun 2003 22:29:59 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: Joseph Fannin <jhf@rivenstone.net>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz, petero2@telia.com
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030611222959.A8473@ucw.cz>
References: <m2u1axk0kp.fsf@p4.localdomain> <20030611131742.3b057c93.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030611131742.3b057c93.akpm@digeo.com>; from akpm@digeo.com on Wed, Jun 11, 2003 at 01:17:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 01:17:42PM -0700, Andrew Morton wrote:

> "Joseph Fannin" <jhf@rivenstone.net> wrote:
> >
> > Here is a driver for the Synaptics TouchPad for 2.5.70.
> 
> The code looks nice.
> 
> > +#include "synaptics.c"
> 
> But why on earth do we need to do this?

I'm sure we don't. That will be fixed easily.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
