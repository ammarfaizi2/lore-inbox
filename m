Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUGTUUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUGTUUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUGTUTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 16:19:09 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:59578 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266257AbUGTURf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 16:17:35 -0400
Date: Tue, 20 Jul 2004 22:17:32 +0200
From: bert hubert <ahu@ds9a.nl>
To: Shesha Sreenivasamurthy <shesha@inostor.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'kernelnewbies@nl.linux.org'" <kernelnewbies@nl.linux.org>
Subject: Re: O_DIRECT
Message-ID: <20040720201732.GA1985@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Shesha Sreenivasamurthy <shesha@inostor.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'kernelnewbies@nl.linux.org'" <kernelnewbies@nl.linux.org>
References: <40FD561D.1010404@inostor.com> <20040720184824.GA30090@outpost.ds9a.nl> <40FD6FCB.5020408@inostor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FD6FCB.5020408@inostor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 12:17:31PM -0700, Shesha Sreenivasamurthy wrote:
> Thank you very much Hubert.
> 
> Regarding my second question, what I mean is, to calculate the soft 
> block size of a partition on which there is no filesystem created, I am 
> using the IOCTL "BLKBSZGET".

Sure - but what do you need this blocksize for?

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
