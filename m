Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWBMTUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWBMTUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWBMTUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:20:18 -0500
Received: from mail.gmx.net ([213.165.64.21]:52183 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932293AbWBMTUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:20:15 -0500
X-Authenticated: #428038
Date: Mon, 13 Feb 2006 20:20:12 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213192012.GA22578@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060213.160108.13290.atrey@ucw.cz> <43F0B32D.nailKUS1E3S8I3@burner> <200602131722.29633.luke@dashjr.org> <43F0C4A3.nailMEM11MHR7@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43F0C4A3.nailMEM11MHR7@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-13:

> -	this bug is known for more than 2 years.
> 
> -	time to fix: less than 3 hours for the right person
> 
> -	I therefore expect a fix in less than a month or
> 	I must asume that Linux is not longer actively maintained.

The kernel jumps at Jörg's command. Film at eleven.
Where's my popcorn?

You were told that ide-scsi fixes are not a priority item,
you were shown that ide-cd works,
you were shown that /dev/hd* and /dev/sg* can share the same namespace
(see my proof-of-concept patch), so there's nothing left for you to
want.

Either fix ide-scsi yourself, or fork a few 50 ¤ bills and contract
somebody to do it.

-- 
Matthias Andree
