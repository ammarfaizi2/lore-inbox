Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTEMRsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbTEMRsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:48:06 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:24983 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262490AbTEMRrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:47:45 -0400
Date: Tue, 13 May 2003 19:00:20 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Mudama, Eric" <eric_mudama@maxtor.com>,
       Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030513180020.GB3309@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
	"Mudama, Eric" <eric_mudama@maxtor.com>,
	Oleg Drokin <green@namesys.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Oliver Neukum <oliver@neukum.org>, lkhelp@rekl.yi.org,
	linux-kernel@vger.kernel.org
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com> <20030512193509.GB10089@gtf.org> <20030512194245.GG17033@suse.de> <20030512195331.GD10089@gtf.org> <20030513064059.GL17033@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513064059.GL17033@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 08:40:59AM +0200, Jens Axboe wrote:
 > > Weird.  Mine doesn't seem to assert it, nor does the identify page
 > > indicate it's supported.  Maybe I have a broken drive firmware.
 > 
 > Then the linux code won't work on it, have you tried? I've tried a lot
 > of different IBM models, they all do service interrupts just fine.

bug in the firmware version on Jeffs drives perhaps ?

		Dave

