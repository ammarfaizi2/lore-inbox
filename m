Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTDOFBM (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 01:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbTDOFBM (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 01:01:12 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:59922 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264265AbTDOFBL (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 01:01:11 -0400
Date: Tue, 15 Apr 2003 07:13:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Robert Love <rml@tech9.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect' document.
Message-ID: <20030415051300.GA1031@mars.ravnborg.org>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Sam Ravnborg <sam@ravnborg.org>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030414193138.GA24870@suse.de> <20030414214807.GB993@mars.ravnborg.org> <1050357422.3664.85.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050357422.3664.85.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 05:57:02PM -0400, Robert Love wrote:
> > Can I safely delete /sbin/update from my initscripts then?
> 
> If you never plan to boot 2.2 or earlier, yes.

Thanks, I just noticed the noise when running dmesg.

	Sam
