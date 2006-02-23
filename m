Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWBWQDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWBWQDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWBWQDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:03:17 -0500
Received: from smtpauth02.mail.atl.earthlink.net ([209.86.89.62]:27825 "EHLO
	smtpauth02.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1751515AbWBWQDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:03:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=mindspring.com;
  b=VXEjO5ay4YgjQhP0XmzgfkdF00PSMuWG+g92dowlp6IfoGos+eeUvb+MqvOnJvNu;
  h=Date:From:To:Cc:Subject:Message-ID:Reply-To:Mail-Followup-To:References:Mime-Version:Content-Type:Content-Disposition:In-Reply-To:Errors-To:X-PGP-RSA-Key:X-PGP-RSA-Fingerprint:X-PGP-DSS-Key:X-PGP-DSS-Fingerprint:X-URL:User-Agent:X-ELNK-Trace:X-Originating-IP;
Date: Thu, 23 Feb 2006 10:02:38 -0600
From: Tim Walberg <twalberg@mindspring.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: herbert@13thfloor.at, matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [OT] portable Makefiles (was: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060223160238.GA31520@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	herbert@13thfloor.at, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org
References: <200602171502.20268.dhazelton@enter.net> <43F9D771.nail4AL36GWSG@burner> <200602201302.05347.dhazelton@enter.net> <43FAE10F.nailD121QL6LN@burner> <20060221101644.GA19643@merlin.emma.line.org> <43FAF2FA.nailD12BW90DH@burner> <20060221114625.GA29439@merlin.emma.line.org> <43FC68C1.nailEC711MJAV@burner> <20060223081257.GA28833@MAIL.13thfloor.at> <43FDD944.nailFUE21NE9H@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FDD944.nailFUE21NE9H@burner>
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.mindspring.com/~twalberg
User-Agent: Mutt/1.5.9i
X-ELNK-Trace: 51223d6fa76962de9c7f779228e2f6aeda0071232e20db4d8c28260e047739d43f64625752a043e4350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 69.3.103.64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2006 16:48 +0100, Joerg Schilling wrote:
>>	Herbert Poetzl <herbert@13thfloor.at> wrote:
>>	
>>	> On Wed, Feb 22, 2006 at 02:36:01PM +0100, Joerg Schilling wrote:
>>	> > ??? smake _is_ a real world make program and if you rate POSIX compliance
>>	> > and portability, it will outstrip all other known make programs.
>>	>
>>	> does anybody (except for the author, of course) use
>>	> smake for building their stuff? just curious ..
>>	
>>	Many people use smake on platforms where there is no other
>>	sufficiently compliant make program.
>>	
>>	As GNU make incorrectly states to run on many plaforms, there are 
>>	a lot of people who suffer from the fact that GNU make is not maintained
>>	since > 6 years.
>>	

Hmmm... from the GNU Make web page:

	Version 3.80 (stable) released on 2002-10-04 00:00:00.000

Seems to me that's slightly less than 6 years, but then I was never
that great at math... Maybe I missed something....



-- 
twalberg@mindspring.com
