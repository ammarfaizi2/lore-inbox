Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWGaU5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWGaU5h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWGaU5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:57:36 -0400
Received: from blinkenlights.ch ([62.202.0.18]:26340 "EHLO blinkenlights.ch")
	by vger.kernel.org with ESMTP id S932496AbWGaU5f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:57:35 -0400
Date: Mon, 31 Jul 2006 22:57:34 +0200
From: Adrian Ulrich <reiser4@blinkenlights.ch>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: matthias.andree@gmx.de, vonbrand@inf.utfsm.cl, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-Id: <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>
In-Reply-To: <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>
	<200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>
Organization: Bluewin AG
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Great to see that Sun ships a state-of-the-art Filesystem with
> > Solaris... I think linux should do the same...
> 
> This would be worthwhile, if only to be able to futz around in Solaris-made
> filesystems.

s/I think linux should do the same/I think linux should include Reiser4/
 ;-)


> First question is if there are any restrictions (patent or otherwise) on
> doing this,

Quoting from
 http://it.sun.com/eventi/jc06/pdf/mi27_p5_poccia_virtualization.pdf

­> 47 ZFS patents added to CDDL patent commons

But i'd rather like to see a Linux version of WAFL :-)

ZFS didn't really impress me: 
The Volume-Manager is nice but the Filesystem.. well: It beats UFS .. sometimes ;-)

See also: http://spam.workaround.ch/dull/postmark.txt

A quick'n'dirty ZFS-vs-UFS-vs-Reiser3-vs-Reiser4-vs-Ext3 'benchmark'



Regards,
 Adrian
