Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbUJ0Aiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbUJ0Aiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbUJ0Aix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:38:53 -0400
Received: from holomorphy.com ([207.189.100.168]:44265 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261593AbUJ0Agj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:36:39 -0400
Date: Tue, 26 Oct 2004 17:36:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Massimo Cetra <mcetra@navynet.it>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041027003612.GM15367@holomorphy.com>
References: <200410262002_MC3-1-8D38-C078@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410262002_MC3-1-8D38-C078@compuserve.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 at 10:37:06 -0700 William Lee Irwin III wrote:
>> It's an existence proof spanning a wide swath of architectures. If
>> you are not seeing similar results, send bugreports.

On Tue, Oct 26, 2004 at 08:00:09PM -0400, Chuck Ebbert wrote:
>   I don't neeed to send in bug reports, there are plenty on l-k
> right now:
>   - LVM is currently broken in 2.6.9-mm1
>   - the RTC and NMI code have a race condition between them
>   - NFS mount won't accept a FQDN over 50 bytes (patch was
>     sent and utterly ignored, then recently reposted)
>   - cdrom driver thinks non-mt. rainier drives are capable

None of the bugs you cite were recently introduced.


On Tue, 26 Oct 2004 at 10:37:06 -0700 William Lee Irwin III wrote:
>> Point releases are in fact updated and maintained. Those updates
>> are given the name of the next point release.

On Tue, Oct 26, 2004 at 08:00:09PM -0400, Chuck Ebbert wrote:
>   Are you saying people who encounter bugs in 2.6.9 should wait for
> 2.6.10?  ...and when they find bugs in _that_ release they should keep
> waiting?  In other words, Zeno was right after all?

Bad idea to try this kind of argument with someone from a domain such as
holomorphy.com. Zeno's mischaracterization of limit arguments was
erroneous and furthermore is irrelevant to discrete models of phenomena,
which don't have indefinite divisibility. In fact, these quantities of
bugs correspond to natural numbers, which yield to infinite descent
arguments, and satisfy descending chain conditions of various kinds.
These are of the form "every descending chain stabilizes", a fortuitous
choice of wording on Artin's part. =)

Upgrade to the later release to get fixes for a given release. This is
not difficult to understand. No point release is "orphaned". The results
of maintaining a point release are the subsequent point releases.

You may also have to face the fact of life that you may actually have to
apply a patch to fix a bug if there's no release to move to yet.


-- wli
