Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292461AbSBZRom>; Tue, 26 Feb 2002 12:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292447AbSBZRoj>; Tue, 26 Feb 2002 12:44:39 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:19951
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292464AbSBZRoM>; Tue, 26 Feb 2002 12:44:12 -0500
Date: Tue, 26 Feb 2002 09:44:55 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Fridtjof Busse <fridtjof.busse@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.18-ac1] Unable to mount root fs
Message-ID: <20020226174455.GO4393@matchmail.com>
Mail-Followup-To: Fridtjof Busse <fridtjof.busse@gmx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202261722.13431@fbunet.de> <20020226164509.GI4393@matchmail.com> <200202261834.39908@fbunet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202261834.39908@fbunet.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 06:40:59PM +0100, Fridtjof Busse wrote:
> On Tuesday, 26. February 2002 17:45, Mike Fedyk wrote:
> > What was the last version of -ac that worked for you?
> 
> I didn't use any ac-Patches of the 2.4.18-pre series, sorry. But I can 
> try some of the pre-ac-patches if that helps you.
> The latest ac I run on my machine was a 2.4.9-ac (don't remember which 
> one exactly).
> The precompiled RH-errata kernel also runs without problems (2.4.9-21).
> 

Did you run 'make oldconfig' after using your old .config file?

Post your .config.  That is probably the problem.
