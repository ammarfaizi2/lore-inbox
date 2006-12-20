Return-Path: <linux-kernel-owner+w=401wt.eu-S965158AbWLTVti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWLTVti (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWLTVth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:49:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42008 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965158AbWLTVtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:49:36 -0500
Subject: Re: Network drivers that don't suspend on interface down
From: Arjan van de Ven <arjan@infradead.org>
To: Benny Amorsen <benny+usenet@amorsen.dk>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <m3ac1icnd4.fsf@ursa.amorsen.dk>
References: <200612191959.43019.david-b@pacbell.net>
	 <20061220042648.GA19814@srcf.ucam.org>
	 <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de>
	 <20061220055209.GA20483@srcf.ucam.org>
	 <1166601025.3365.1345.camel@laptopd505.fenrus.org>
	 <20061220125314.GA24188@srcf.ucam.org>
	 <1166621931.3365.1384.camel@laptopd505.fenrus.org>
	 <20061220152701.GA22928@dspnet.fr.eu.org>
	 <1166628858.3365.1425.camel@laptopd505.fenrus.org>
	 <20061220164054.GA27938@dspnet.fr.eu.org>
	 <1166635300.3365.1442.camel@laptopd505.fenrus.org>
	 <m3ac1icnd4.fsf@ursa.amorsen.dk>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 20 Dec 2006 22:49:33 +0100
Message-Id: <1166651374.3365.1449.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 21:40 +0100, Benny Amorsen wrote:
> >>>>> "AvdV" == Arjan van de Ven <arjan@infradead.org> writes:
> 
> AvdV> even if you have NO power savings you still don't meet your
> AvdV> criteria. That's basic ethernet for you....
> 
> AvdV> That's what I was trying to say; your criteria is unrealistic
> AvdV> regardless of what the kernel does, ethernet already dictates 30
> AvdV> to 45 seconds there.
> 
> Can you get to such high numbers without STP?

you can get the 30 seconds yes. Usually not with home equipment though,
but with longer cables and expensive switches.. it does happen.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

