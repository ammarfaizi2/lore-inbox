Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTDWSpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbTDWSp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:45:28 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:10393 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264294AbTDWSod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:44:33 -0400
Date: Wed, 23 Apr 2003 20:56:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Pat Suwalski <pat@suwalski.net>, Matthias Schniedermeyer <ms@citd.de>,
       Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030423185612.GB18170@wohnheim.fh-wedel.de>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423172120.GA12497@citd.de> <3EA6947D.9080106@suwalski.net> <1527920000.1051118798@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1527920000.1051118798@flay>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 April 2003 10:26:38 -0700, Martin J. Bligh wrote:
> 
> But I fail to understand how the distro can magically set a sensible 
> default, and yet we're unable to do so inside the kernel ? Setting it
> to something like 10 (or other very quiet setting) would seem reasonable.
> Then at least the poor user would have a clue what the problem was.

Pick any number and it will be either too loud or below the fan noise
for some users, maybe both. The only number that has the same effect
for all users happens to be the number I personally would prefer as a
default and the alsa people have chosen.

What is wrong with 0? Even aunt tilly will figure out what the deal
it and it depends on the distribution if she can find the right
solution for this.

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens
