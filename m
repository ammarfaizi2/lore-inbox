Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbUKQGnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbUKQGnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 01:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUKQGnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 01:43:39 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:25316 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262184AbUKQGnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 01:43:31 -0500
Subject: Re: 2.6.10-rc2-mm1
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041116182233.097d9d85.akpm@osdl.org>
References: <20041116014213.2128aca9.akpm@osdl.org>
	 <1100640653.16765.0.camel@krustophenia.net>
	 <20041116182233.097d9d85.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 21:28:20 -0500
Message-Id: <1100658500.17573.10.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-16 at 18:22 -0800, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> >  On Tue, 2004-11-16 at 01:42 -0800, Andrew Morton wrote:
> >  > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.10-rc2-mm1.gz
> >  > 
> > 
> >  Why was the VIA DRM removed?  It was in 2.6.9-mm1 but seems to be gone
> >  now.
> 
> Actually I haven't been updating that for a while, because of ghastly
> conflicts upstream.  Then it disappeared altogether due to administrative
> error.
> 
> I'll see if I can resurrect it.

OK thanks.  Not many people use the 3D but there are now Xine and
mplayer plugins that use the DRI for hardware accelerated playback on
this chip.

Lee

