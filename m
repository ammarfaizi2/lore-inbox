Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVG1B1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVG1B1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVG1B1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:27:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64741 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261504AbVG1B0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:26:46 -0400
Subject: Re: 2.6.12: no sound on SPDIF with emu10k1
From: Lee Revell <rlrevell@joe-job.com>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: fedora-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1122513715.13792.22.camel@hostmaster.org>
References: <1122493585.3137.14.camel@hostmaster.org>
	 <1122497052.22844.5.camel@mindpipe>
	 <1122513715.13792.22.camel@hostmaster.org>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 21:26:45 -0400
Message-Id: <1122514005.22844.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 03:21 +0200, Thomas Zehetbauer wrote:
> On Wed, 2005-07-27 at 16:44 -0400, Lee Revell wrote:
> > On Wed, 2005-07-27 at 21:46 +0200, Thomas Zehetbauer wrote:
> > > I cannot get my SB Live! 5.1's SPDIF (digital) output to work with
> > > kernel > 2.6.12. I have not changed my mixer configuration and it is
> > > still working when I boot 2.6.11.12 or earlier. I am using FC4 with
> > > alsa-lib-1.0.9rf-2.FC4 installed.
> > 
> > FC4 shipped a buggy ALSA version, I can't believe there are no updated
> > RPMs yet.
> > 
> > You need a newer ALSA.
> 
> alsa-lib-1.0.9rf-2 is the latest update available:

You have to update all alsa packages, not just alsa-lib.

Lee

