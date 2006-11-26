Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935225AbWKZB0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935225AbWKZB0k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 20:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935226AbWKZB0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 20:26:40 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:50706 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP id S935225AbWKZB0j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 20:26:39 -0500
Date: Sun, 26 Nov 2006 02:26:30 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
Message-ID: <20061126012630.GF17074@vanheusden.com>
References: <ek2nva$vgk$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ek2nva$vgk$1@sea.gmane.org>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sun Nov 26 15:32:54 CET 2006
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hornburg:~# cat /proc/sys/kernel/random/entropy_avail
> 0

Please have a look at:
audio-entropyd: http://www.vanheusden.com/aed/
fills the kernel entropy buffer with noise from your audio-card
video-entropyd: http://www.vanheusden.com/ved/
fills the kernel entropy buffer with noise from a video4linux device,
e.g. a webcam or a framegrabber or whaterver


Folkert van Heusden

-- 
www.vanheusden.com/multitail - win een vlaai van multivlaai! zorg
ervoor dat multitail opgenomen wordt in Fedora Core, AIX, Solaris of
HP/UX en win een vlaai naar keuze
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
