Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVBHIPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVBHIPi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 03:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVBHIPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 03:15:38 -0500
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:54538 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP id S261479AbVBHIPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 03:15:34 -0500
Message-ID: <42087524.4040800@gentoo.org>
Date: Tue, 08 Feb 2005 08:15:32 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
References: <20050207221107.GA1369@elf.ucw.cz>	<20050207145100.6208b8b9.akpm@osdl.org>	<420801D7.3020405@gentoo.org> <20050207161810.23fcc4f1.akpm@osdl.org>
In-Reply-To: <20050207161810.23fcc4f1.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CyQWv-000PVf-15*5DYyzwdsLDQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton wrote:
> Bah.  That's what happens when you fix stuff.
> 
> What's kylix?  The Borland C++ builder thing?
> 
> How should one set about reproducing this problem?

You don't need the kylix environment or libraries, you just need to run any 
binary that was compiled with kylix. Teamspeak was the one that brought the 
issue to our attention. Here's a direct link:

ftp://ftp.freenet.de/pub/4players/teamspeak.org/releases/ts2_client_rc2_2032.tar.bz2

I will test your diagnosis patch later today, if nobody else has.

Daniel
