Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWI2Fhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWI2Fhn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 01:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161230AbWI2Fhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 01:37:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:59585 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161225AbWI2Fhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 01:37:42 -0400
X-Authenticated: #5039886
Date: Fri, 29 Sep 2006 07:37:39 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: David Schwartz <davids@webmaster.com>
Cc: Neil Brown <neilb@suse.de>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
Message-ID: <20060929053739.GB21048@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	David Schwartz <davids@webmaster.com>, Neil Brown <neilb@suse.de>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20060929030518.GA21048@atjola.homenet> <MDEHLPKNGKAHNMBLJOLKCENMOLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKCENMOLAB.davids@webmaster.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.09.28 20:31:07 -0700, David Schwartz wrote:
> 
> > It's in section 1, where it says "keep intact all the notices that refer
> > to this License" (section 2 refers to section 1).
> > The current GPLv3 draft says (section 4): "keep intact all license
> > notices".
> >
> > Notice a difference? I'm not a native speaker and of course IANAL, but
> > AFAICT, with "v2 or later", if you follow the terms of GPLv2, you are
> > only required to keep notices refering to THAT license, ie. GPLv2, so
> > you seem to be allowed to remove the GPLv3 notices. But if you follow
> > the terms of the GPLv3, you are required to keep ALL license notices,
> > including those that refer to v2.
> > So you could actually never ever make a "v2 or later" program a
> > "v3 only" program, but only a "v2 only".
> >
> > Am I missing something?
> 
> That section uses the phrase "this license" twice. I think it's only
> reasonable to assume it means the same thing in both places. It says you
> must "give any other recipients of the Program a copy of this License along
> with the Program".
> 
> If "this license" means GPLv2, then the GPLv2 does not allow you to remove
> the GPLv2 notice. I think it's somewhat absurd to say that you must include
> a copy of the license but may take away their right to use the code under
> that license.
> 
> If "this license" means "whatever license you happen to have to this
> program", then you cannot remove or modify *any* license notices, including
> the "GPLv2 or later at your option" notice.
> 
> I see no plausible way to argue that GPLv2 permits you to change "GPLv2 or
> later at your option" to "GPLv3 or later at your option". If GPLv3 does not
> either, then you may not do so.

That's what I'm saying (ok, I didn't mention the "GPLv3 or later"
wording). Once v3 is out, you can choose between v2 and v3.
v2 seems to only forces you to keep the notice that v2 is valid.
The current v3 draft forces you to keep all license notices.

So if at all, you can only remove anything _but_ v2, but never v2.


But I've just re-read section 9 and "this License" obviously just refers to
just the GPL there, as the version number of "this License" is mentioned.
So removing the "or later" won't work either and you simply cannot change
which versions apply at all (at least not without all copyright holders
agreeing on that change).

Björn
