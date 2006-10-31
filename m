Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423589AbWJaQvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423589AbWJaQvt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423590AbWJaQvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:51:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61140 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423589AbWJaQvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:51:48 -0500
Date: Tue, 31 Oct 2006 11:51:33 -0500
From: Dave Jones <davej@redhat.com>
To: ray-gmail@madrabbit.org
Cc: "Martin J. Bligh" <mbligh@google.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
Message-ID: <20061031165133.GB23354@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, ray-gmail@madrabbit.org,
	"Martin J. Bligh" <mbligh@google.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com> <2c0942db0610310834i6244c0abm10c81e984565ed8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0942db0610310834i6244c0abm10c81e984565ed8a@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 08:34:23AM -0800, Ray Lee wrote:
 > On 10/31/06, Martin J. Bligh <mbligh@google.com> wrote:
 > > > At some point we should get rid of all the "politeness" warnings, just
 > > > because they can end up hiding the _real_ ones.
 > >
 > > Yay! Couldn't agree more. Does this mean you'll take patches for all the
 > > uninitialized variable crap from gcc 4.x ?
 > 
 > What would be useful in the short term is a tool that shows only the
 > new warnings that didn't exist in the last point release.

git clone git://git.kernel.org/pub/scm/linux/kernel/git/viro/remapper.git

Daily snapshots available at http://www.codemonkey.org.uk/projects/git-snapshots/remapper/

	Dave


-- 
http://www.codemonkey.org.uk
