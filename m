Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbUAHM3S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 07:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUAHM3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 07:29:18 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:32270 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S264368AbUAHM3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 07:29:18 -0500
Date: Thu, 8 Jan 2004 13:29:16 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Message-ID: <20040108122916.GA72001@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FFB12AD.6010000@sun.com> <Pine.LNX.4.53.0401071139430.20046@simba.math.ucla.edu> <3FFC8E5B.40203@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFC8E5B.40203@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 05:55:23PM -0500, Mike Waychison wrote:
> Yes, an 'ls' actually does an lstat on every file.

I guess you haven't met the plague called color-ls yet.  Lucky you.

Most modern file browsers also seem to feel obligated to follow
symlinks to check whether they're dangling.  A mis-click on "up" when
you're on your home directory could cause a beautiful mount-storm.

  OG.

