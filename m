Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTLJNRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbTLJNRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:17:25 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:15829 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263561AbTLJNRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:17:22 -0500
X-Sender-Authentication: net64
Date: Wed, 10 Dec 2003 14:17:19 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: paul@clubi.ie, marcelo.tosatti@cyclades.com, thornber@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-Id: <20031210141719.1c8d5033.skraw@ithnet.com>
In-Reply-To: <20031210120336.GU8039@holomorphy.com>
References: <20031210120336.GU8039@holomorphy.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003 04:03:36 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> On Tue, 9 Dec 2003, William Lee Irwin III wrote:
> >>> Just apply the patch if you're for some reason terrified of 2.6.
> 
> On Wed, 10 Dec 2003 00:15:17 +0000 (GMT) Paul Jakma <paul@clubi.ie> wrote:
> >> Or get RedHat or Fedora to apply the patch.
> 
> On Wed, Dec 10, 2003 at 11:49:28AM +0000, skraw@ithnet.com wrote:
> > There it is again, this /dev/null argument.
> > "Multi-billion dollar companies" have gone bancrupt on the simple
> > fact that diversification of one product can rattle customers/users
> > to a degree that they in fact decide against the whole product range.
> > IOW go on with the idea to spread around an unknown number of kernel
> > versions and you can be sure that linux as a whole will greatly suffer.
> > This is a "user" issue, not a "developer" issue of course. Developers
> > can apply any kind of patches they like, but don't go and tell the
> > vast user base to "just apply patch xyz". They won't honor this at
> > all, your level of acceptance will dramatically drop.
> 
> One of the main reasons to have an open source OS is customization.
> Arguing that it's not truly feasible to customize will not hold water.

Are you calling a user-configured (not user-patched) kernel "customized" or
not?
_The_ top reason (at least when reading Al's posts :-) is probably that the
source is cross-checked by many eyes. If you create a infinite number of
patched kernel-versions it is obvious you will loose this primary advantage.
The more versions the fewer cross-checking.
IOW a "customized" but instable OS values exactly zero.

> Pretty much every "productized" version of Linux is heavily customized
> to get some kind of value-add. There's no reason to bother mainline
> with this; if it's a serious user issue of that magnitude vendors will
> pick it up.

"Serious" is a subjective argument, therefore different people see different
issues as serious. In my opinion a kernel.org kernel should cover most if not
all possible stable customizations, see it as a pool.
So my primary question for inclusion would not be "what is it worth?" but "does
it do any harm?". I am not god, therefore I do not and can not judge 
"worthness". Can you?

Regards,
Stephan

