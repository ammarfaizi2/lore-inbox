Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262579AbSI0UmC>; Fri, 27 Sep 2002 16:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262587AbSI0UmC>; Fri, 27 Sep 2002 16:42:02 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:63755
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262579AbSI0UmC>; Fri, 27 Sep 2002 16:42:02 -0400
Subject: Re: [ANNOUNCE] procps 2.0.8
From: Robert Love <rml@tech9.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: procps-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0209271657330.22735-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0209271657330.22735-100000@imladris.surriel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1033159620.22056.14.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 27 Sep 2002 16:47:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-27 at 16:00, Rik van Riel wrote:

> It appears Robert and I cleaned up stuff a bit too much
> and procps lost it's VERSION string, so -V doesn't work
> in the tarball I released earlier today.
> 
> Also, it appears the release has awoken some long sleeping
> patches, which I'll read and (if they work) integrate into
> procps.

<brown paper bag>

Whoops!  To make up for it, I just made tarballs and RPM packages of the
latest CVS dump, which includes the version fixes and one or two other
minor patches since 2.0.8.

They are available at: http://tech9.net/rml/procps/

</brown paper bag>

	Robert Love

