Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUAHNU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 08:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbUAHNU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 08:20:56 -0500
Received: from [212.28.208.94] ([212.28.208.94]:22533 "HELO dewire.com")
	by vger.kernel.org with SMTP id S264365AbUAHNUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 08:20:55 -0500
From: Robin Rosenberg <robin.rosenberg@dewire.com>
To: Olivier Galibert <galibert@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Thu, 8 Jan 2004 14:20:52 +0100
User-Agent: KMail/1.5.3
References: <3FFB12AD.6010000@sun.com> <3FFC8E5B.40203@sun.com> <20040108122916.GA72001@dspnet.fr.eu.org>
In-Reply-To: <20040108122916.GA72001@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401081420.52248.robin.rosenberg@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torsdagen den 8 januari 2004 13.29 skrev Olivier Galibert:
> On Wed, Jan 07, 2004 at 05:55:23PM -0500, Mike Waychison wrote:
> > Yes, an 'ls' actually does an lstat on every file.
>
> I guess you haven't met the plague called color-ls yet.  Lucky you.
>
> Most modern file browsers also seem to feel obligated to follow
> symlinks to check whether they're dangling.  A mis-click on "up" when
> you're on your home directory could cause a beautiful mount-storm.
>

Not to mention the more complex graphical environments like Konqueror in KDE which produces a 
nice icon with a preview of whatever the a link points to. It also scans directories in 
order to tag the large icon with an even smaller icons to indicate what type of files the directory 
contains. It is very nice, but very different from ls.

-- robin

