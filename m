Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135587AbRDSICo>; Thu, 19 Apr 2001 04:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135588AbRDSICe>; Thu, 19 Apr 2001 04:02:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47369 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S135587AbRDSIC2>;
	Thu, 19 Apr 2001 04:02:28 -0400
Date: Thu, 19 Apr 2001 09:02:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Cross-referencing frenzy
Message-ID: <20010419090220.A2291@flint.arm.linux.org.uk>
In-Reply-To: <20010418233445.A28628@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010418233445.A28628@thyrsus.com>; from esr@thyrsus.com on Wed, Apr 18, 2001 at 11:34:45PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 11:34:45PM -0400, Eric S. Raymond wrote:
> Especially look for CONFIG_* symbols that only occur in .c or .h files.
> I think almost every one of those lines represents a bug that needs to be
> fixed.

It'd be easier to read if they were alphanumerically sorted.

The ones that show up in arch/arm/def-configs are purely because I've been
keeping back the updates to these files; each time the config structure
changes, I get a nice big patch from people with the new def-configs.  I
didn't want to inflict this too regularly on people.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

