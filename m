Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264071AbTDOUbu (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 16:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTDOUbu 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 16:31:50 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:30480 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264071AbTDOUbs 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 16:31:48 -0400
Date: Tue, 15 Apr 2003 22:43:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writing modules for 2.5
Message-ID: <20030415204338.GA1312@mars.ravnborg.org>
Mail-Followup-To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <yw1x7k9w9flm.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x7k9w9flm.fsf@zaphod.guide>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 01:15:17PM +0200, Måns Rullgård wrote:
> 
> What magic needs to be done when writing modules for linux 2.5.x?

First of all you need to follow Documentation/modules.txt when
compiling modules.
If you try to make your own build system you are sure to hit problems.

	Sam
