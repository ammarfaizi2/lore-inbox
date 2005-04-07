Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVDGONZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVDGONZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 10:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVDGONZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 10:13:25 -0400
Received: from heavensgate.debian.net ([213.41.173.23]:44695 "EHLO
	heavensgate.debian.net") by vger.kernel.org with ESMTP
	id S261489AbVDGONW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 10:13:22 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Josselin Mouette <joss@debian.org>
To: linux-os@analogic.com
Cc: debian-kernel@lists.debian.org, debian-legal@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk
In-Reply-To: <Pine.LNX.4.61.0504070855510.29251@chaos.analogic.com>
References: <L0f93D.A.68G.D2OVCB@murphy> <4255278E.4000303@almg.gov.br>
	 <Pine.LNX.4.61.0504070855510.29251@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 07 Apr 2005 16:15:45 +0200
Message-Id: <1112883345.6421.42.camel@silicium.ccc.cea.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 07 avril 2005 à 09:03 -0400, Richard B. Johnson a écrit :
> Well it doesn't make any difference. If GPL has degenerated to
> where one can't upload microcode to a device as part of its
> initialization, without having the "source" that generated that
> microcode, we are in a lot of hurt. Intel isn't going to give their
> designs away.

The GPL doesn't forbid that. The GPL forbids to put this microcode
directly in the same binary as the GPL code. Of course, nothing forbids
some GPL'ed code to take a binary elsewhere and to upload it into the
hardware.

At least that's my opinion; AIUI, Sven Luther believes it is possible if
the firmware has a decent (but not necessarily free) license.
-- 
 .''`.           Josselin Mouette        /\./\
: :' :           josselin.mouette@ens-lyon.org
`. `'                        joss@debian.org
   `-  Debian GNU/Linux -- The power of freedom

