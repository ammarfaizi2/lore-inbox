Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbTEWMqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264059AbTEWMqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:46:00 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:37124 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S264057AbTEWMp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:45:58 -0400
Date: Fri, 23 May 2003 06:58:41 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>, willy@w.ods.org
cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-ID: <428570000.1053694721@aslan.scsiguy.com>
In-Reply-To: <20030523123837.6521738f.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>	<2804790000.1052441142@aslan.scsiguy.com>
 	<20030509120648.1e0af0c8.skraw@ithnet.com>	<20030509120659.GA15754@alpha.home.local>	<20030509150207.3ff9cd64.skraw@ithnet.com>
 	<20030509145738.GB17581@alpha.home.local>	<20030512110218.4bbc1afe.skraw@ithnet.com> <20030523123837.6521738f.skraw@ithnet.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. I managed to crash the tested machine after 14 days now. The crash itself
> is exactly like former 2.4.21-X. It just freezes, no oops no nothing. It looks
> like things got better, but not solved.

What is telling you that the freeze is SCSI related?  Are you running
with the nmi watchdog and have a trace?  Do you have driver messages
that you aren't sharing?

--
Justin

