Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965373AbWJBToG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965373AbWJBToG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965389AbWJBToF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:44:05 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:52719 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S965373AbWJBToE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:44:04 -0400
Date: Mon, 2 Oct 2006 12:39:17 -0700
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Dan Williams <dcbw@redhat.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Norbert Preining <preining@logic.at>,
       Alessandro Suardi <alessandro.suardi@gmail.com>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061002193917.GA14966@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <20061002113259.GA8295@gamma.logic.tuwien.ac.at> <5a4c581d0610020521q721e3157q88ad17d3cc84a066@mail.gmail.com> <20061002124613.GB13984@gamma.logic.tuwien.ac.at> <20061002165053.GA2986@gamma.logic.tuwien.ac.at> <1159808304.2834.89.camel@localhost.localdomain> <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <d120d5000610021234s3cb0388bi26b5493fc85e4974@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000610021234s3cb0388bi26b5493fc85e4974@mail.gmail.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 03:34:04PM -0400, Dmitry Torokhov wrote:
> On 10/2/06, Jean Tourrilhes <jt@hpl.hp.com> wrote:
> >
> >       The whole point of the -rc process is to find problems and the
> >scope of it, there is no way I can know everything. At this point, we
> >can decide if WE-21 should go in 2.6.19 or wait for 2.6.20. But I know
> >that most Linux-Wireless people such as Dan and Jouni have been
> >waiting impatiently for those changes...
> >
> 
> It would be nice if need of a specific version of wireless tools was
> documented in Documentaion/Changes. It was a surprise for me when my
> wireless card stopped working.

	The Wireless Tols themselves issue a nice warning telling you
about the version mismatch and the need to upgrade. This is even more
powerful, as most people don't read the doc, but they run the tools.
	Don't tell my you ignored the warning !

> Dmitry

	Jean
