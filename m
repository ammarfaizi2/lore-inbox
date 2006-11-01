Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946761AbWKAK5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946761AbWKAK5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946771AbWKAK5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:57:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:45018 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946761AbWKAK5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:57:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TGoXtFQlZc6TjYVr14ADj3NI/pTOdL4fp/uQSg1OFqdeQEaX2BN4GAbPGarp9WOwdWWJAP/KPlxnj3az2XUBscWhD+rCi38ofuW/vaili1jhVxSm+X3vAGeAJk4y5Q7kdhKELB/TE1RhzONkt9hlRfKsd3t+imqTJz1wIRNbUns=
Message-ID: <d512a4f30611010257g1e64adacm8fdcea6b3d04b773@mail.gmail.com>
Date: Wed, 1 Nov 2006 11:57:02 +0100
From: "Sylvain Bertrand" <sylvain.bertrand@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [Bugme-new] [Bug 7437] New: VIA VT8233 seems to suffer from the via latency quirk
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Chris Wedgwood" <cw@f00f.org>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>
In-Reply-To: <20061101061741.GA25208@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610310020.k9V0KGQK003237@fire-2.osdl.org>
	 <20061030163458.4fb8cee1.akpm@osdl.org>
	 <d512a4f30610301703r68dfa848s116475b68435f136@mail.gmail.com>
	 <20061031034342.GC11944@kroah.com>
	 <d512a4f30610311755g11054e88w36f35e93205722a7@mail.gmail.com>
	 <20061101061741.GA25208@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I will send an email. In the mean time, I may experiment enabling
some of the PCI quirks. Do you have some hints on the quirks which
could be good candidates?

2006/11/1, Greg KH <greg@kroah.com>:
> On Wed, Nov 01, 2006 at 02:55:18AM +0100, Sylvain Bertrand wrote:
> > I enabled the via latency quirk code for my chipset and my workstation
> > does crash the same way.
> > Then, my crash problem seems not related to this quirk even if
> > symptoms are quite similar.
>
> Thank you for testing.  Can you try contacting VIA to find out what
> needs to be fixed here?
>
