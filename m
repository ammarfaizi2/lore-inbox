Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVAFMHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVAFMHC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 07:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVAFMHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 07:07:02 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:55242 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S262630AbVAFMG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 07:06:58 -0500
Date: Thu, 6 Jan 2005 12:06:27 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501061203250.23199@student.dei.uc.pt>
References: <20050106002240.00ac4611.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCT-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCT-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 6 Jan 2005, Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm2/
>
> - Various minorish updates and fixes

The acpi_power_off issue (acpi_power_off is called but the laptop doesn't shut
down) is back (in -mm1 already). I suspect it has never disappear completely:
maybe it only happens in some cenarios (like "only when AC is plugged in" or
something like that). The report is done, I'll try to get more info soon (when
does this happen and when it doesn't) and will report it by then.

Mind Booster Noori

- -- 
/* *************************************************************** */
    Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
    http://student.dei.uc.pt/~marado   -	  marado@student.dei.uc.pt
    () Join the ASCII ribbon campaign against html email, Microsoft
    /\ attachments and Software patents.   They endanger the World.
    Sign a petition against patents:  http://petition.eurolinux.org
/* *************************************************************** */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFB3SnFmNlq8m+oD34RAk0+AJ97ZQZI0a+JuGT3uXG+w/sSjtcP6ACfVbCJ
dP7EcQYa+xXN4OyuQpO4cvU=
=13Cu
-----END PGP SIGNATURE-----

