Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbUAAPt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 10:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUAAPt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 10:49:59 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:16911 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264420AbUAAPt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 10:49:57 -0500
Date: Thu, 1 Jan 2004 16:48:31 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Rob Love <rml@ximian.com>
Cc: rob@landley.net, Andries Brouwer <aebr@win.tue.nl>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040101164831.A2431@pclin040.win.tue.nl>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <20040101001549.GA17401@win.tue.nl> <1072917113.11003.34.camel@fur> <200401010634.28559.rob@landley.net> <1072970573.3975.3.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1072970573.3975.3.camel@fur>; from rml@ximian.com on Thu, Jan 01, 2004 at 10:22:53AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 10:22:53AM -0500, Rob Love wrote:

> Device numbers are 64-bit now.
> 
> 	Rob Love

I am afraid I have to disappoint you. I made them 64-bit,
and I think they were 64-bit for a few months in the -mm tree,
forgot the details, but unfortunately Al went back to 32-bit again.

