Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbTFLSIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbTFLSII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:08:08 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:52655 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264927AbTFLSIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:08:05 -0400
Date: Thu, 12 Jun 2003 19:21:34 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: John Goerzen <jgoerzen@complete.org>
Cc: Mark Watts <m.watts@eris.qinetiq.com>, linux-kernel@vger.kernel.org
Subject: Re: cpufreq on Pentium M
Message-ID: <20030612182134.GA24001@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	John Goerzen <jgoerzen@complete.org>,
	Mark Watts <m.watts@eris.qinetiq.com>, linux-kernel@vger.kernel.org
References: <87n0go3pcp.fsf@complete.org> <20030612061803.GA21509@suse.de> <200306121510.01876.m.watts@eris.qinetiq.com> <20030612144450.GD8146@suse.de> <20030612152127.GA1529@wile.excelhustler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612152127.GA1529@wile.excelhustler.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 10:21:27AM -0500, John Goerzen wrote:
 > On Thu, Jun 12, 2003 at 03:44:50PM +0100, Dave Jones wrote:
 > > On Thu, Jun 12, 2003 at 03:10:01PM +0100, Mark Watts wrote:
 > > 
 > >  > Thought this may help:
 > >  > - From a Dell D600 w/ 1.6Ghz Pentium M cpu...
 > > 
 > > Yep, the latest bunch of cache descriptors are missing from 2.4
 > > (They're in 2.5 already). I did send these to Marcelo, but they
 > > seem to have got lost when we entered -rc stage.
 > > I'll resend them for 2.4.22pre
 > 
 > Is it already too late for 2.4.21rc?

Yes. Exactly the same thing happened for .20rc, but with different
descriptors. Despite the change being so harmless its almost in the
'nothing can possibly go wrong' zone, Marcelo wanted to hold back.

		Dave

