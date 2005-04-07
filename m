Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVDGS2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVDGS2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVDGS2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:28:13 -0400
Received: from smtp.istop.com ([66.11.167.126]:17123 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262537AbVDGS2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:28:11 -0400
From: Daniel Phillips <phillips@istop.com>
To: Dmitry Yusupov <dima@neterion.com>
Subject: Re: Kernel SCM saga..
Date: Thu, 7 Apr 2005 14:29:24 -0400
User-Agent: KMail/1.7
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <200504071354.34581.phillips@istop.com> <1112897620.3893.62.camel@beastie>
In-Reply-To: <1112897620.3893.62.camel@beastie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504071429.25073.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 April 2005 14:13, Dmitry Yusupov wrote:
> On Thu, 2005-04-07 at 13:54 -0400, Daniel Phillips wrote:
> > Three years ago, there was no fully working open source distributed scm
> > code base to use as a starting point, so extending BK would have been the
> > only easy alternative.  But since then the situation has changed.  There
> > are now several working code bases to provide a good starting point:
> > Monotone, Arch, SVK, Bazaar-ng and others.
>
> Right. For example, SVK is pretty mature project and very close to 1.0
> release now. And it supports all kind of merges including Cherry-Picking
> Mergeback:
>
> http://svk.elixus.org/?MergeFeatures

So for an interim way to get the patch flow back online, SVK is ready to try 
_now_, and we only need a way to import the version graph?  (true/false)

Regards,

Daniel
