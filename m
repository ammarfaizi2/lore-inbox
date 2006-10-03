Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWJCQoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWJCQoG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWJCQoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:44:05 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:32234 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932281AbWJCQoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:44:02 -0400
Date: Tue, 3 Oct 2006 09:41:22 -0700
To: Dan Williams <dcbw@redhat.com>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Theodore Tso <tytso@mit.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       jt@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003164122.GC17252@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <200610022147.03748.rjw@sisk.pl> <1159822831.11771.5.camel@localhost.localdomain> <20061002212604.GA6520@thunk.org> <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com> <1159877574.2879.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159877574.2879.11.camel@localhost.localdomain>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 08:12:53AM -0400, Dan Williams wrote:
> 
> But, as far as I know (please correct me if I'm wrong), that 2.6.18
> doesn't actually include WE-21! [1]  Somebody is trying to run
> out-of-kernel ipw3945 drivers using a 2.6.18 kernel from FC5 that's
> WE-20 only, but the driver uses WE-21?

	No, It was out-of-kernel ipw3945 + 2.6.18-git9 kernel. The
kernel was using WE-21 and the driver was using WE-20.

	Jean
