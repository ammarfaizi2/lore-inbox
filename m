Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266528AbTGEWoM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 18:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbTGEWoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 18:44:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2712 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S266528AbTGEWoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 18:44:12 -0400
Date: Sat, 5 Jul 2003 19:56:14 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix sim scsi build
In-Reply-To: <200307051630.h65GUTXY009347@hraefn.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0307051953430.14251@freak.distro.conectiva>
References: <200307051630.h65GUTXY009347@hraefn.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This one doesnt apply cleanly against the current bk tre:

[marcelo@freak linux-2.4]$ dotest < /tmp/simscsi
bk import -tpatch -CR -yPATCH: fix sim scsi build /tmp/patch14314 .
Make sure there are no locked files in /home/marcelo/bk/linux-2.4 ...
Make sure there are no extra files in /home/marcelo/bk/linux-2.4 ...
Patching...
8 out of 9 hunks FAILED -- saving rejects to file
drivers/scsi/sim710_d.h.rej

Could you please regenerate?

