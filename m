Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbTDOMIj (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbTDOMIj 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:08:39 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:24324 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id S261301AbTDOMIi 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 08:08:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
Message-Id: <200304151416.35797@gandalf>
To: Petr Cisar <petr.cisar@gtsgroup.cz>, Petr Cisar <pc@cuculus.switch.gts.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Date: Tue, 15 Apr 2003 14:20:12 +0200
X-Mailer: KMail [version 1.3.2]
References: <20030415133608.A1447@cuculus.switch.gts.cz>
In-Reply-To: <20030415133608.A1447@cuculus.switch.gts.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 April 2003 13:36, Petr Cisar wrote:
> Hello
> 
> Since 2.5.60, I have been experiencing problems with a complete system 
freeze or random oopses when the X-server terminates. It is happening on both 
machines I am using whose hardware configuration differs slightly, however 
both of them are equipped with ATI video cards (ATI Rage 128 and ATI Radeon 
8500), and both of them run the same version of X-server. That's about all 
they have in common.
> 
> The version of X-server I am using is:
> XFree86 Version 4.3.0
> Release Date: 27 February 2003

seen it to (~60% of the time)
my X is quite old:
XFree86 Version 4.2.0 / X Window System
(protocol Version 11, revision 0, vendor release 6600)
Release Date: 18 January 2002

thought that it was a problem of X and didn't have time to update it 
(although I played with a lot of -mm kernels since 2.5.64).

	Rudmer
