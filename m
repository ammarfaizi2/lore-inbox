Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTF2Tuv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbTF2Tsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:48:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35735 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264884AbTF2TsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:48:20 -0400
Date: Sun, 29 Jun 2003 21:02:39 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jamie Lokier <jamie@shareable.org>
Cc: "Leonard Milcin Jr." <thervoy@post.pl>, rmoser <mlmoser@comcast.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas
Message-ID: <20030629200239.GI27348@parcelfarce.linux.theplanet.co.uk>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <200306291445470220.01DC8D9F@smtp.comcast.net> <3EFF3FFA.60806@post.pl> <20030629194423.GE26258@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030629194423.GE26258@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 08:44:23PM +0100, Jamie Lokier wrote:
> Leonard Milcin Jr. wrote:
> > >Nrrrg.  Yeah, I've got 80 gig and only CDR's to back up to, and no money.
> > >A CDR may read for me the day it's written, and then not work the next
> > >day.  Still a risk.
> > 
> > Say, why you would want to change filesystem type?
> 
> I'd like to try reiser4 when it is available because I heard from Hans
> that it is faster...
> 
> Isn't that a good reason?

Not really.  Never, ever, try a new code on live system.  Put together
a test box and/or test disk.  Regardless of nature of code in question -
if you want to test something, go for a dedicated test setup.
