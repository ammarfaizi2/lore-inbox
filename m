Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131982AbRC1QIW>; Wed, 28 Mar 2001 11:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131990AbRC1QIM>; Wed, 28 Mar 2001 11:08:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8970 "EHLO www.linux.org.uk") by vger.kernel.org with ESMTP id <S131982AbRC1QID>; Wed, 28 Mar 2001 11:08:03 -0500
From: rmk@arm.linux.org.uk
Message-Id: <200103281554.QAA01342@raistlin.arm.linux.org.uk>
Subject: Re: Disturbing news..
To: pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard)
Date: Wed, 28 Mar 2001 16:54:00 +0100 (BST)
Cc: nwahofm@mi.uni-erlangen.de, spstarr@sh0n.net (Shawn Starr), linux-kernel@vger.kernel.org
In-Reply-To: <200103281551.JAA49453@tomcat.admin.navo.hpc.mil> from "Jesse Pollard" at Mar 28, 2001 09:51:39 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard writes:
> Absolutely true. The only help the checksumming etc stuff is good for is
> detecting the fact afterward by external comparison.

Don't we already have that to some extent?  rpm -ya or rpm -y <package name>
on a RedHat system?  I'm sure that there is a Debian equivalent.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

