Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267973AbTAKTVi>; Sat, 11 Jan 2003 14:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268004AbTAKTVi>; Sat, 11 Jan 2003 14:21:38 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:24069 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267973AbTAKTVh>; Sat, 11 Jan 2003 14:21:37 -0500
Date: Sat, 11 Jan 2003 19:30:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: make AT_SYSINFO platform-independent
Message-ID: <20030111193022.A6267@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ulrich Drepper <drepper@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <200301110645.h0B6jQRu026921@napali.hpl.hp.com> <20030111110717.A24094@infradead.org> <3E2067FE.4060803@redhat.com> <20030111185744.A5009@infradead.org> <3E206B41.2090203@redhat.com> <20030111191347.A5413@infradead.org> <3E206F7A.4060600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E206F7A.4060600@redhat.com>; from drepper@redhat.com on Sat, Jan 11, 2003 at 11:24:42AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 11:24:42AM -0800, Ulrich Drepper wrote:
> I see no reason to not believe Linus when he says an interface is
> stable.  And that's exactly what he said (or wrote in this case).

Linus had no problem with changing his opinion after strong words in the
past :)

But what exactly is the problem with a changing defintion for you.  There
is neither a stable kernel nor a formal glibc release with this defined
out yet.  That means the ABI isn't formalized and the number can be
allocated where it belongs.

Who cares what Linus said in the past as long as Linux development goes
to the right direction?

