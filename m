Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTFYPly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTFYPly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:41:54 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:26886 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264592AbTFYPlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:41:50 -0400
Date: Wed, 25 Jun 2003 16:56:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marek Habersack <grendel@debian.org>
Cc: Steve Lord <lord@sgi.com>, Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.73-mm1 XFS] restrict_chown and quotas
Message-ID: <20030625165600.A24244@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marek Habersack <grendel@debian.org>, Steve Lord <lord@sgi.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030625095126.GD1745@thanes.org> <1056545505.1170.19.camel@laptop.americas.sgi.com> <20030625134129.GG1745@thanes.org> <1056551143.5779.0.camel@laptop.fenrus.com> <20030625153545.A16074@infradead.org> <1056553902.1416.61.camel@laptop.americas.sgi.com> <20030625161627.A20049@infradead.org> <20030625153943.GJ1745@thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030625153943.GJ1745@thanes.org>; from grendel@debian.org on Wed, Jun 25, 2003 at 05:39:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 05:39:43PM +0200, Marek Habersack wrote:
> This being clear, maybe it should be a compile-time option in XFS? Or
> would that be unacceptable?

Yes.  It's also utterly pointless.

