Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312396AbSCYLNr>; Mon, 25 Mar 2002 06:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312397AbSCYLNi>; Mon, 25 Mar 2002 06:13:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12561 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312393AbSCYLN0>; Mon, 25 Mar 2002 06:13:26 -0500
Date: Mon, 25 Mar 2002 12:13:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: NBD client/server broken?
Message-ID: <20020325111320.GD3144@atrey.karlin.mff.cuni.cz>
In-Reply-To: <5.1.0.14.2.20020324125307.02899da0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have been trying to get nbd to work, the server is 2.4.18-pre7-ac2 and 
> the client is 2.5.7, and the exported device is /dev/hda1 a 15GiB partition.
> 
> I found and downloaded nbd.14.tar.gz. Is this the latest and
> greatest?

Latest is the one in cvs at nbd.sf.net. Please use that.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
