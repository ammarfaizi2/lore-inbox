Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131841AbRC1OzC>; Wed, 28 Mar 2001 09:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131842AbRC1Oyw>; Wed, 28 Mar 2001 09:54:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:263 "EHLO www.linux.org.uk") by vger.kernel.org with ESMTP id <S131841AbRC1Oyl>; Wed, 28 Mar 2001 09:54:41 -0500
Date: Wed, 28 Mar 2001 15:53:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: kaos@ocs.com.au, jesse@cats-chateau.net, linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
Message-ID: <20010328155331.B6867@flint.arm.linux.org.uk>
References: <200103281415.IAA47715@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103281415.IAA47715@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Wed, Mar 28, 2001 at 08:15:57AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 08:15:57AM -0600, Jesse Pollard wrote:
> objcopy - copies object files. Object files are not marked executable...

objcopy copies executable files as well - check the kernel makefiles
for examples.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

