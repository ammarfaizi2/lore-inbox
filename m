Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUJAVT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUJAVT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUJAVS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:18:27 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:50103 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266643AbUJAU5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:57:34 -0400
Date: Fri, 1 Oct 2004 22:57:27 +0200
From: bert hubert <ahu@ds9a.nl>
To: "Shesha B.  Sreenivasamurthy" <shesha@inostor.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: md hangs while rebuilding
Message-ID: <20041001205727.GA30680@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"Shesha B.  Sreenivasamurthy" <shesha@inostor.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernelnewbies@nl.linux.org
References: <1096658210.9342.1525.camel@arcane>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096658210.9342.1525.camel@arcane>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 12:16:51PM -0700, Shesha B.  Sreenivasamurthy wrote:

> I have 9 disks raid 1. I pulled out 4 disks, and using raidhotadd I
> triggered a rebuild on 3 of them. While rebuilding md1, the rebuilding
> process is stuck at 0.0%. Below is a snapshot of "/proc/mdstat". 

Please please please tell people what kernel you run with and your exact
configuration.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
