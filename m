Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265306AbUFXTWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265306AbUFXTWs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265312AbUFXTWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:22:04 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:4630 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265302AbUFXTQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:16:48 -0400
Date: Thu, 24 Jun 2004 21:29:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Greg KH <greg@kroah.com>, Chris Friesen <cfriesen@nortelnetworks.com>,
       Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.7.0
Message-ID: <20040624192946.GB3037@mars.ravnborg.org>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	Greg KH <greg@kroah.com>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
References: <200406240102.23162.mmazur@kernel.pl> <40DA16E8.6070902@nortelnetworks.com> <20040624055832.GA10531@kroah.com> <20040624135343.GH3072@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624135343.GH3072@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 03:53:43PM +0200, Andries Brouwer wrote:
> Let me contradict this. Several people, probably independently,
> submitted a header setup and a patch that did the required work
> for a small handful of header files.

Header file cleanup has a tendency to break the compile in some configurations.
This was obvious during the effort to clean up the include mess in the 2.5 time.

That's maybe the primary reason to postpone it to 2.7.

	Sam
