Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbUJ0CrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbUJ0CrC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUJ0CrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:47:02 -0400
Received: from smtp.dei.uc.pt ([193.137.203.228]:24199 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261587AbUJ0Cqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:46:50 -0400
Date: Wed, 27 Oct 2004 03:45:21 +0100 (WEST)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Massimo Cetra <mcetra@navynet.it>
Subject: Re: My thoughts on the "new development model"
In-Reply-To: <20041027003612.GM15367@holomorphy.com>
Message-ID: <Pine.LNX.4.61.0410270342250.20284@student.dei.uc.pt>
References: <200410262002_MC3-1-8D38-C078@compuserve.com>
 <20041027003612.GM15367@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 26 Oct 2004, William Lee Irwin III wrote:

>>> It's an existence proof spanning a wide swath of architectures. If
>>> you are not seeing similar results, send bugreports.
>>
>>   I don't neeed to send in bug reports, there are plenty on l-k
>> right now:
>>   - LVM is currently broken in 2.6.9-mm1
>>   - the RTC and NMI code have a race condition between them
>>   - NFS mount won't accept a FQDN over 50 bytes (patch was
>>     sent and utterly ignored, then recently reposted)
>>   - cdrom driver thinks non-mt. rainier drives are capable
>
> None of the bugs you cite were recently introduced.

Is it relevant?
They exist, they must be fixed. If there is relevancy in this issue, the matter
is "why do we care more about recently introduced bugs (that can be avoided by
using a not-so-recent kernel) instead of caring about those well-known
long-dated bugs?".

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

iD8DBQFBfwvCmNlq8m+oD34RAo55AJ9cOHkhxYnA21anwlWkDj34V51KNACg48Pt
yqOQ1GX/Xgszr6yNft/2BL4=
=VeDx
-----END PGP SIGNATURE-----

