Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbTAOAMG>; Tue, 14 Jan 2003 19:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbTAOAMG>; Tue, 14 Jan 2003 19:12:06 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:30973 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265484AbTAOAMF>; Tue, 14 Jan 2003 19:12:05 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200301142006.25592.ivanovich@menta.net> 
References: <200301142006.25592.ivanovich@menta.net> 
To: Ivanovich <ivanovich@menta.net>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: 2.5.58 - bttv broken? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Jan 2003 00:20:57 +0000
Message-ID: <6867.1042590057@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ivanovich@menta.net said:
> Just tried my tv card (Miro PCTV) with 2.5.58 and TV output looks very
> wrong. It gets drawn outside the xawtv window (displaced to the left,
> more displaced  if the window is placed in the right of the screen
> ?!?), it's B&W instead of  color, and shows ugly vertical black lines.

Try 'xawtv -bpp 24'.

Also try updating your X server to one which does Xv.

--
dwmw2


