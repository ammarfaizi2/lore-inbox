Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263609AbTCUMq4>; Fri, 21 Mar 2003 07:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263613AbTCUMq4>; Fri, 21 Mar 2003 07:46:56 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:64903 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263609AbTCUMqz>; Fri, 21 Mar 2003 07:46:55 -0500
Date: Fri, 21 Mar 2003 12:57:46 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Daniel Pittman <daniel@rimspace.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux <-> Linux NFS issues.
Message-ID: <20030321125719.GA30102@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Daniel Pittman <daniel@rimspace.net>, linux-kernel@vger.kernel.org
References: <87isudm2ee.fsf@enki.rimspace.net> <20030321123214.GB6664@suse.de> <shs1y103mrr.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shs1y103mrr.fsf@charged.uio.no>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 01:52:08PM +0100, Trond Myklebust wrote:

 > Are you seeing bogus packets from both the 2.5.x client and the
 > server, or is it just the server (or just the client)?
 > It could also be interesting to find out if this is a UDP only
 > problem, or if it occurs with TCP too...

To be honest, I've forgotten what the exact issues were.
I'll rerun some tests this afternoon, and post the results.
>From what I do recall, it was fairly simple to trigger,
an fsx run made 'bad shit' happen within a minute or two.

		Dave

