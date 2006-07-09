Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbWGIU1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWGIU1f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbWGIU1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:27:35 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:25312 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161123AbWGIU1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:27:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LzwXj7iabhgm38tRwhT86WkK8lVDRNuSYGk+FaBn2wSEjUs8KBjW2WEDvxX/DV+MKIWclhvPDzeRFnntj7ffIILrWJBp3MywSeRmU243+MUDFKQ/iUDnX8MQ8UCUeiMlUXcca/rMWjDzy3r/6sVB3aMn66uMZJiD6NmT1ajgjx4=
Message-ID: <e1e1d5f40607091327y3db1cbdco89ebdb04cda60ce0@mail.gmail.com>
Date: Sun, 9 Jul 2006 16:27:33 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Automatic Kernel Bug Report
Cc: "Adrian Bunk" <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200607092019.k69KJt66005527@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
	 <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com>
	 <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com>
	 <20060709125805.GF13938@stusta.de>
	 <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com>
	 <20060709191107.GN13938@stusta.de>
	 <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
	 <200607092019.k69KJt66005527@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Sun, 09 Jul 2006 16:01:58 EDT, Daniel Bonekeeper said:
>
> > Sometimes the user may be just somebody that just started using linux,
> > or is in an industry that has nothing related to computers. He doesn't
> > even know that syslog exists, and even if he did, he could not even
> > care about it.
>
> This user will do whatever his distro tells him to do, which is almost
> certainly something *other* than what a kernel.org kernel should do.
> If he's running Ubuntu, it should do whatever Ubuntu does.  If he's
> on Fedora Core, it should poke the RedHat bugzilla, and so on.
>
> If he's running a kernel.org kernel, it's probably safe to assume *some*
> level of clue
>

This was actually just an example circunstance of why somebody would
not report a bug. Dozens of other circunstances may be given, and it
just illustrates why would be good to have those bug reports without
user interaction. Of course I can go to bugzilla and fill a report
upon a bug, but I wouldn't care to have bug reports being sent from my
servers automatically, if it's an option. This would ensure that even
bug report from non-caring users are, well, reported.

Daniel
-- 
What this world needs is a good five-dollar plasma weapon.
