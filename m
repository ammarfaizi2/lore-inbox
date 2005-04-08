Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbVDHITK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbVDHITK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVDHIRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 04:17:10 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.28]:13103 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262759AbVDHIK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 04:10:57 -0400
X-ME-UUID: 20050408081043410.6423C1C00380@mwinf0303.wanadoo.fr
Date: Fri, 8 Apr 2005 10:06:25 +0200
To: Josselin Mouette <joss@debian.org>
Cc: linux-os@analogic.com, debian-kernel@lists.debian.org,
       debian-legal@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050408080625.GH9057@pegasos>
References: <L0f93D.A.68G.D2OVCB@murphy> <4255278E.4000303@almg.gov.br> <Pine.LNX.4.61.0504070855510.29251@chaos.analogic.com> <1112883345.6421.42.camel@silicium.ccc.cea.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1112883345.6421.42.camel@silicium.ccc.cea.fr>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 04:15:45PM +0200, Josselin Mouette wrote:
> Le jeudi 07 avril 2005 à 09:03 -0400, Richard B. Johnson a écrit :
> > Well it doesn't make any difference. If GPL has degenerated to
> > where one can't upload microcode to a device as part of its
> > initialization, without having the "source" that generated that
> > microcode, we are in a lot of hurt. Intel isn't going to give their
> > designs away.
> 
> The GPL doesn't forbid that. The GPL forbids to put this microcode
> directly in the same binary as the GPL code. Of course, nothing forbids
> some GPL'ed code to take a binary elsewhere and to upload it into the
> hardware.

No, i am arguing, that we can consider here the binary as a media
distribution, in the same way as we would clearly separate the compressor from
the compressed data in a auto-uncompressing executable, or the firmware from
the firmware flasher in a all-in-one firmware upgrade binary.

> At least that's my opinion; AIUI, Sven Luther believes it is possible if
> the firmware has a decent (but not necessarily free) license.

Indeed, the sole problem is that the current copyright and licencing
attributions de-facto sets those firmware blobs under the GPL, which of course
makes them undistributable since the GPL clearly claims that we need source
code for it, and if any condition of the GPL fails, the program becomes
undistributable as a whole.

Friendly,

Sven Luther

