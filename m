Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275591AbTHOAQm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 20:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275593AbTHOAQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 20:16:42 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:46084
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S275591AbTHOAQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 20:16:41 -0400
Date: Thu, 14 Aug 2003 17:16:32 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Matt Mackall <mpm@selenic.com>,
       James Morris <jmorris@intercode.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Network Card Entropy? was: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815001632.GI1027@matchmail.com>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Theodore Ts'o <tytso@mit.edu>, Matt Mackall <mpm@selenic.com>,
	James Morris <jmorris@intercode.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, davem@redhat.com
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030811020919.GD10446@mail.jlokier.co.uk> <20030813035257.GB1244@think> <20030813183628.GC4405@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813183628.GC4405@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 07:36:28PM +0100, Jamie Lokier wrote:
> Unfortunately it isn't airtight if the attacker can see the file in
> flight to your NFS-mounted diskless box, although booting over NFS
> would tend to introduce enough entropy by itself so we are fine here :)

Assuming that all network drivers are contributing entropy...

Was Robert Love's patch for this ever merged?
