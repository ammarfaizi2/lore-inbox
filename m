Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbTEKMID (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTEKMID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:08:03 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:28033
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261192AbTEKMIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:08:02 -0400
Date: Sun, 11 May 2003 08:11:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Grzesiek Wilk <toulouse@put.mielec.pl>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SiS648 support for agpgart, kernel 2.4.21-rc2-ac1
In-Reply-To: <Pine.SOL.4.30.0305111409470.1501-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.50.0305110810340.15337-100000@montezuma.mastecende.com>
References: <Pine.SOL.4.30.0305111409470.1501-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 May 2003, Bartlomiej Zolnierkiewicz wrote:

> On Sun, 11 May 2003, Grzesiek Wilk wrote:
> 
> > This patch just adds sis648 chipset support as a generic sis chipset into
> > agpgart. You need it if you want to get a 3d acceleration to work.
> >
> > So far it works fine on my Radeon 9000
> > (glxgears 1200fps instead of 300, glTron works excellent).

Wow that's horrendous.

-- 
function.linuxpower.ca
