Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbVJDOzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVJDOzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVJDOzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:55:49 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:25605 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932510AbVJDOzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:55:49 -0400
Date: Tue, 4 Oct 2005 16:55:37 +0200
From: Olivier Galibert <galibert@pobox.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Infinite interrupt loop, INTSTAT = 0
Message-ID: <20051004145537.GA95274@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20050928160744.GA37975@dspnet.fr.eu.org> <1127924686.4852.11.camel@mulgrave> <20050928171052.GA45082@dspnet.fr.eu.org> <1127929909.4852.34.camel@mulgrave> <20050928183324.GA51793@dspnet.fr.eu.org> <1128175434.4921.9.camel@mulgrave> <20051003134210.GA10641@dspnet.fr.eu.org> <1128356144.4606.11.camel@mulgrave> <20051004084533.GA59492@dspnet.fr.eu.org> <1128432181.4782.3.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128432181.4782.3.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 09:23:01AM -0400, James Bottomley wrote:
> OK, that sort of confirms the theory that there's a bad interaction at
> u320.  What I'll try to do is to implement the bios parameter routines
> for the aic79xx and you can set it to u160 in the bios.  Since I can't
> test this, would you be a guinea pig when I come up with it?

No problem.

  OG.
