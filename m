Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbUJZTSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUJZTSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 15:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbUJZTSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 15:18:06 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:28283 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261450AbUJZTOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 15:14:25 -0400
From: "Ian Campbell" <ijc@hellion.org.uk>
Date: Tue, 26 Oct 2004 20:11:44 +0100
To: David Vrabel <dvrabel@arcom.com>, Linus Torvalds <torvalds@osdl.org>,
       Len Brown <len.brown@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Versioning of tree
Message-ID: <20041026191144.GA8580@hellion.org.uk>
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe> <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org> <20041025234736.GF10638@michonline.com> <417E39AE.5020209@arcom.com> <20041026122632.GH10638@michonline.com> <20041026190815.GA8338@mars.ravnborg.org> <20041026180408.GI10638@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026180408.GI10638@michonline.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 02:04:09PM -0400, Ryan Anderson wrote:
> I was planning on a followup version that would add a CONFIG variable,
> i.e, CONFIG_LOCALVERSION_AUTO, that drove this whole additional step, and
> at the same time, to work out a similar method to do this for CVS.

Isn't there already CONFIG_LOCALVERSION? If you have to set _AUTO in
your config then you may as well just bash -bk into CONFIG_LOCALVERSION.

Ian.
