Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTDOQej (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbTDOQej 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:34:39 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:63131 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261764AbTDOQeQ (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 12:34:16 -0400
Date: Tue, 15 Apr 2003 17:45:41 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUGed to death
Message-ID: <20030415164535.GD17152@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Michael Buesch <fsdeveloper@yahoo.de>, linux-kernel@vger.kernel.org
References: <20030415143024.GA10117@rushmore> <20030415155708.GB17152@suse.de> <200304151842.35624.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304151842.35624.fsdeveloper@yahoo.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 06:42:35PM +0200, Michael Buesch wrote:
 > On Tuesday 15 April 2003 17:57, Dave Jones wrote:
 > > Imagine I pass in 20. Previously, the BUG triggers. Not any more.
 > > Ditto the other changes.  Or am _I_ missing something ?
 > 
 > Yes ;)
 > You're missing the (not posted) while loop before. Just look into source.

Yup. I stand corrected.

		Dave

