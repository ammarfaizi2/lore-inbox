Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVBLAX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVBLAX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 19:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVBLAX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 19:23:56 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:4769 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262266AbVBLAXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 19:23:34 -0500
Date: Sat, 12 Feb 2005 01:23:19 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Narayan Desai <desai@mcs.anl.gov>
Cc: John M Flinchbaugh <john@hjsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: intel8x0 alsa outputs no sound
Message-ID: <20050212002319.GA12498@louise.pinerecords.com>
References: <20050204213337.GA12347@butterfly.hjsoft.com> <874qgqu0ej.fsf@topaz.mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874qgqu0ej.fsf@topaz.mcs.anl.gov>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb-05 2005, Sat, 16:06 -0600
Narayan Desai <desai@mcs.anl.gov> wrote:

> Try muting the headphone jack sense control with alsamixer. I had the
> same problem with rc2 on my t41p, and that solved it.

This doesn't help on a T40p, I'm afraid.
No sound in 2.6.11-rc3 with snd-intel8x0.ko, worked all ok in 2.6.10.

-- 
Tomas Szepe <szepe@pinerecords.com>
