Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUHJN3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUHJN3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUHJN2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:28:54 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:52117 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265139AbUHJN1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:27:09 -0400
Date: Tue, 10 Aug 2004 15:27:09 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810132709.GB31836@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <200408101241.i7ACf5WC013958@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408101241.i7ACf5WC013958@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2004-08-10:

> So you really like to recommend everyone to cross the street while the 
> traffic light shows red just because you did not yet get any harm from doing 
> so? 

Of course not, but you cannot claim I've been harmed crossing the street
when the lights were red when I haven't.

There are dangers when mlockall() or similar and RT scheduling don't
succeed, but that doesn't mean something MUST happen. The warning IMO is
right but let's just ditch this part of the discussion.  cdrecord user
interface discussion is off-topic here.

-- 
Matthias Andree

NOTE YOU WILL NOT RECEIVE MY MAIL IF YOU'RE USING SPF!
Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
