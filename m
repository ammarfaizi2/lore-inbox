Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbTGOSyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269461AbTGOSyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:54:18 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:12448 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S269451AbTGOSyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:54:14 -0400
Date: Tue, 15 Jul 2003 20:08:59 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unable to boot linux-2.6-test1
Message-ID: <20030715190859.GA20424@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	linux-kernel@vger.kernel.org
References: <20030715185852.GA519@sokrates>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715185852.GA519@sokrates>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 08:58:52PM +0200, Michael Kristensen wrote:
 > * Dave Jones <davej@codemonkey.org.uk> [2003-07-15 20:33:00]:
 > >> CONFIG_INPUT=m
 > > Because this is m, Kconfig is hiding CONFIG_VT from you.
 > 
 > When I read the help for CONFIG_VT, I was convinced that was it, but
 > when I tried to enable CONFIG_VT it still didn't work. It just sounded
 > so like that was it. Any other suggestions?

Read the 'common gotchas' section of
http://www.codemonkey.org.uk/post-halloween.txt
It's likely one of the other options in that list.

		Dave
