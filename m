Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWGZFxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWGZFxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 01:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWGZFxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 01:53:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25543 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751361AbWGZFxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 01:53:07 -0400
Date: Tue, 25 Jul 2006 22:52:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jordan Crouse" <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, blizzard@redhat.com, dwmw2@redhat.com,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/2] OLPC + Geode fixups
Message-Id: <20060725225256.b4f98887.akpm@osdl.org>
In-Reply-To: <20060724165046.18787.23690.stgit@cosmic.amd.com>
References: <20060724165046.18787.23690.stgit@cosmic.amd.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006 10:50:46 -0600
"Jordan Crouse" <jordan.crouse@amd.com> wrote:

> The following two patches are in support of the OLPC project.  I sent these
> patches before, but somewhere along the line I failed to correctly follow up.

Actually I sneakily snuck
git://git.infradead.org/users/jcrouse/geode.git#linus-upstream into -mm (as
git-geode.patch) a month ago - it's been there since 2.6.17-mm3.

So assuming that tree is being kept up-to-date, I don't need to do
anything.  Please arrange for the relevant subsystem maintainers to review
the bits of your tree which affect them (as you have done) and then send a
pull request to Linus at the appropriate time, cc'ing myself.

Unless there are significant bugfixes or this is a new subsystem, the
appropriate time would be in the post-2.6.18 two-week merge window.

And please let me know when there are -mm-affecting changes in that git tree.
Sometimes people add new branches without telling me, or they leave me
carrying abandoned stuff.
