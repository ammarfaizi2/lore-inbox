Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTIEAT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 20:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTIEAT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 20:19:58 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:29708 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261366AbTIEAT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 20:19:57 -0400
Date: Fri, 5 Sep 2003 02:19:55 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Chris Heath <chris@heathens.co.nz>,
       linux-kernel@vger.kernel.org, vojtech@ucw.cz,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Message-ID: <20030905021955.A3133@pclin040.win.tue.nl>
References: <20030903235647.C765.CHRIS@heathens.co.nz> <20030904204816.GD31590@mail.jlokier.co.uk> <20030905003436.A3105@pclin040.win.tue.nl> <20030904230055.GO31590@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030904230055.GO31590@mail.jlokier.co.uk>; from jamie@shareable.org on Fri, Sep 05, 2003 at 12:00:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 12:00:55AM +0100, Jamie Lokier wrote:

> Are you saying that it isn't possible for i8042.c to simply pass all
> events (including duplicates) to the keyboard driver to sanitise?

I am saying that I would like nothing better than that.
But it is a fundamental change of setup.


