Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbUCRN3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 08:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbUCRN3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 08:29:13 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:28168 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S262612AbUCRN2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 08:28:55 -0500
Date: Thu, 18 Mar 2004 14:29:37 +0100
From: Felix von Leitner <felix-kernel@fefe.de>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remove kernel features (for embedded systems)
Message-ID: <20040318132937.GB29111@codeblau.de>
References: <20040318130640.GA28923@codeblau.de> <200403181311.i2IDB3dE000721@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403181311.i2IDB3dE000721@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake John Bradford (john@grabjohn.com):
> > And if it is at all possible, I would like to be able to remove parts of
> > the IP stack, e.g. routing.  In particular, I would like to be able to
> > remove policy routing, if it is at all worth it from the code size point
> > of view.
> Why not just write your own IP stack in userspace, if you're doing a
> heavily embedded system?

People use Linux _because_ of the IP stack.
They just normally don't need all of it.
And I propose to let them remove the parts they don't need.

Felix
