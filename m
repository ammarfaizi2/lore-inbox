Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277533AbRKHTS2>; Thu, 8 Nov 2001 14:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277568AbRKHTSI>; Thu, 8 Nov 2001 14:18:08 -0500
Received: from zero.tech9.net ([209.61.188.187]:52496 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S277552AbRKHTSD>;
	Thu, 8 Nov 2001 14:18:03 -0500
Subject: Re: Any lingering Athlon bugs in Kernel 2.4.14?
From: Robert Love <rml@tech9.net>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111081315500.4578-100000@rtlab.med.cornell.edu>
In-Reply-To: <Pine.LNX.4.30.0111081315500.4578-100000@rtlab.med.cornell.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 08 Nov 2001 14:18:17 -0500
Message-Id: <1005247097.866.41.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-08 at 13:17, Calin A. Culianu wrote:
> I wouldn't mind trying his tree at all.  Does his tree somehow use the
> older VM, or does it try to address Athlon bugs more aggressively? Ie: Why
> is this a great idea?  (Apart from Alan's tree just being really cool).

It does use the older VM, and more importantly it has some odd end fixes
that have yet to be incorporated into Linus's tree.  And, yes, it is
just really cool :)

After that, I would look into compiling without optimization.

Also, what exactly happens on the systems?  Do they hard lock?  Do you
have an oops?

	Robert Love

