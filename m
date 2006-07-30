Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWG3TyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWG3TyF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWG3TyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:54:04 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:55500 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S932465AbWG3TyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:54:02 -0400
Date: Sun, 30 Jul 2006 21:53:42 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Tomasz Torcz <zdzichu@irc.pl>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk
Subject: Re: 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
Message-ID: <20060730195342.GA32665@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Arjan van de Ven <arjan@infradead.org>,
	Tomasz Torcz <zdzichu@irc.pl>, linux-kernel@vger.kernel.org,
	zwane@arm.linux.org.uk
References: <20060730120844.GA18293@outpost.ds9a.nl> <20060730160738.GB13377@irc.pl> <1154288811.2941.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154288811.2941.45.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 09:46:51PM +0200, Arjan van de Ven wrote:

> as a side note ... you realize that clockmod doesn't actually save you
> any power right? ;)

Indeed, and I've measured that too. But it saves an awful amount of noise!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
