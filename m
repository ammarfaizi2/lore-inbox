Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282980AbRK0W3l>; Tue, 27 Nov 2001 17:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282989AbRK0W3c>; Tue, 27 Nov 2001 17:29:32 -0500
Received: from zero.tech9.net ([209.61.188.187]:11018 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282983AbRK0W3T>;
	Tue, 27 Nov 2001 17:29:19 -0500
Subject: Re: 2.5.1-pre2 does not compile
From: Robert Love <rml@tech9.net>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200111272209.fARM9tk18991@ns.caldera.de>
In-Reply-To: <200111272209.fARM9tk18991@ns.caldera.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Nov 2001 17:29:45 -0500
Message-Id: <1006900187.1874.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-27 at 17:09, Christoph Hellwig wrote:

> While we are at breaking scsi, would you take a patch to remove the
> old-style (2.0) scsi error handling completly, forcing drivers still
> using it to be fixed?  Early 2.5 looks like a good time for that to me..

Linus, please consider this at some early point.  There isn't too much
using the scsi_obsolete gunk anyhow, but let's clean it up.  Good idea.

	Robert Love

