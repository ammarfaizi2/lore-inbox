Return-Path: <linux-kernel-owner+w=401wt.eu-S932701AbWLTUkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbWLTUkx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbWLTUkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:40:53 -0500
Received: from main.gmane.org ([80.91.229.2]:39186 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932701AbWLTUkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:40:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Benny Amorsen <benny+usenet@amorsen.dk>
Subject: Re: Network drivers that don't suspend on interface down
Date: 20 Dec 2006 21:40:23 +0100
Message-ID: <m3ac1icnd4.fsf@ursa.amorsen.dk>
References: <200612191959.43019.david-b@pacbell.net> <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de> <20061220055209.GA20483@srcf.ucam.org> <1166601025.3365.1345.camel@laptopd505.fenrus.org> <20061220125314.GA24188@srcf.ucam.org> <1166621931.3365.1384.camel@laptopd505.fenrus.org> <20061220152701.GA22928@dspnet.fr.eu.org> <1166628858.3365.1425.camel@laptopd505.fenrus.org> <20061220164054.GA27938@dspnet.fr.eu.org> <1166635300.3365.1442.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 10.8.185.213.dk-amb.res.sta.perspektivbredband.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Cc: netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AvdV" == Arjan van de Ven <arjan@infradead.org> writes:

AvdV> even if you have NO power savings you still don't meet your
AvdV> criteria. That's basic ethernet for you....

AvdV> That's what I was trying to say; your criteria is unrealistic
AvdV> regardless of what the kernel does, ethernet already dictates 30
AvdV> to 45 seconds there.

Can you get to such high numbers without STP?


/Benny


