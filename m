Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965440AbWJBWIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965440AbWJBWIG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 18:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965443AbWJBWIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 18:08:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:14692 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965440AbWJBWID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 18:08:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YhQfWlehL4AWSHuxD1dNeG8dEB2nRgXwojcv2I6jMJOqij6NEtWKVh4H9+X5zw3AJroTgkWKZVGqIQxSN8mUethUZDQrDMOz42omUdxm+suGf0HY2rKuDPyZseHYyRDdhQ/2RVL9AeLivFcYHemdo+tRyxxD+grODfcUFSabCd0=
Message-ID: <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com>
Date: Tue, 3 Oct 2006 00:08:01 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>, "Dan Williams" <dcbw@redhat.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, jt@hpl.hp.com,
       "Andrew Morton" <akpm@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       "Norbert Preining" <preining@logic.at>,
       "Alessandro Suardi" <alessandro.suardi@gmail.com>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
In-Reply-To: <20061002212604.GA6520@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <20061002111537.baa077d2.akpm@osdl.org>
	 <20061002185550.GA14854@bougret.hpl.hp.com>
	 <200610022147.03748.rjw@sisk.pl>
	 <1159822831.11771.5.camel@localhost.localdomain>
	 <20061002212604.GA6520@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/06, Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Oct 02, 2006 at 05:00:31PM -0400, Dan Williams wrote:
> > Distributions _are_ shipping those tools already.  The problem is more
> > with older distributions where, for example, the kernel gets upgraded
> > but other stuff does not.  If a kernel upgrade happens, then the distro
> > needs to make sure userspace works with it.  That's nothing new.
>
> Um, *which* distro's are shipping it already?  RHEL4?  SLES10?  I
> thought we saw a note saying that even Debian **unstable** didn't have
> a new enough version of the wireless-tools....

That was my point initially. FC5-latest is apparently carrying
 tools which are "too old"... and I yum update twice or thrice
 a week. Not that *I* minded building packages from source,
 but this is likely a bit too much for a good slice of the userbase.

Ciao,

--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')
