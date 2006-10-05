Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWJEAbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWJEAbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWJEAbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:31:36 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:15832 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1751265AbWJEAbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:31:35 -0400
Date: Wed, 4 Oct 2006 17:30:44 -0700
To: Theodore Tso <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061005003044.GB5145@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org> <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org> <20061004185903.GA4386@bougret.hpl.hp.com> <20061004232939.GA19647@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004232939.GA19647@thunk.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 07:29:39PM -0400, Theodore Tso wrote:
> 
> P.S.  Because of all of these changing interfaces, I *still* haven't
> been able to get wpa_supplicant working with LEAP so I can get
> wireless access to in IBM offices using my ipw3945 driver.  I've
> tried, and failed.  Sigh, I guess I'm not smart enough....

	Which changing interface are you talking about ? I'm afraid
that WPA is a complex business and the ipw3945 driver is still
beta. Jouni and the people on the hostap mailing list should be able
to help.
	Regards,

	Jean

