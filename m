Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVC1TkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVC1TkA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVC1TkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:40:00 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:52115 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S262038AbVC1Tjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:39:37 -0500
Date: Mon, 28 Mar 2005 21:39:35 +0200
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: 20050323135317.GA22959@roonstrasse.net, linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
Message-ID: <20050328193933.GH943@vanheusden.com>
References: <20050328172820.GA31571@linux.ensimag.fr>
	<20050328175614.GG943@vanheusden.com>
	<Pine.LNX.4.61.0503282131560.11428@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503282131560.11428@yvahk01.tjqt.qr>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Sat Mar 26 23:38:20 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I already posted one, posts ago.
> >>[snip]
> >Imporved version:
> >[snip]
> >char *dummy = (char *)malloc(1);
> That cast is not supposed to be there, is it? (To pretake it: it's bad.)

What is so bad about it?


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!
