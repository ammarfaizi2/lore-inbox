Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWGaINM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWGaINM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 04:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWGaINM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 04:13:12 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:45216 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1751290AbWGaINL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 04:13:11 -0400
Date: Mon, 31 Jul 2006 10:12:51 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: David Rees <drees76@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
Message-ID: <20060731081251.GA25440@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	David Rees <drees76@gmail.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Tomasz Torcz <zdzichu@irc.pl>, linux-kernel@vger.kernel.org
References: <20060730120844.GA18293@outpost.ds9a.nl> <20060730160738.GB13377@irc.pl> <1154288811.2941.45.camel@laptopd505.fenrus.org> <20060730195342.GA32665@outpost.ds9a.nl> <72dbd3150607310050v1b3e5a9y23f40777fb00aac4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72dbd3150607310050v1b3e5a9y23f40777fb00aac4@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 12:50:07AM -0700, David Rees wrote:
> >Indeed, and I've measured that too. But it saves an awful amount of noise!
> 
> If it doesn't save you power, how does it reduce noise? I guess it
> keeps you from overheating your processor which causes the fan to spin
> up?

I have no idea. Perhaps heat production moves somewhere else. But you are
free to come listen to the difference p4-clockmod makes for me. 

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
