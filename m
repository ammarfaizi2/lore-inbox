Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVBRLxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVBRLxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 06:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVBRLxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 06:53:11 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:43410 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261332AbVBRLxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 06:53:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=n7PLMGCQy4oUewkLrvYEW1pWYi4Xg2lQ16n15UyGaj92q8Glv5dEPJK7n8mI2fDrqk3pv3Gua1x8tiKPnNffRSAGnH6U6x3tWVNJTLKapLV4W6qxYvusG2G6opTmYpfiBvlmKIdL+lr8v8+x4pweKVRcry9y8zy8alCJwaVPDS4=
Message-ID: <845b6e8705021803533ba8cc34@mail.gmail.com>
Date: Fri, 18 Feb 2005 12:53:09 +0100
From: =?ISO-8859-1?Q?Erik_B=E5gfors?= <zindar@gmail.com>
Reply-To: =?ISO-8859-1?Q?Erik_B=E5gfors?= <zindar@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Cc: Tupshin Harper <tupshin@tupshin.com>, darcs-users@darcs.net,
       lm@bitmover.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050218090900.GA2071@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050214020802.GA3047@bitmover.com>
	 <200502172105.25677.pmcfarland@downeast.net>
	 <421551F5.5090005@tupshin.com> <20050218090900.GA2071@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 10:09:00 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> On Thu, Feb 17, 2005 at 06:24:53PM -0800, Tupshin Harper wrote:
> > small to medium sized ones). Last I checked, Arch was still too slow in
> > some areas, though that might have changed in recent months. Also, many
> 
> IMHO someone needs to rewrite ARCH using the RCS or SCCS format for the
> backend and a single file for the changesets and with sane parameters
> conventions miming SVN.

RCS/SCCS format doesn't make much sence for a changeset oriented SCM.

/Erik
