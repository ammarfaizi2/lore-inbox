Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTJANil (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTJANik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:38:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17292 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262128AbTJANik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:38:40 -0400
Date: Wed, 1 Oct 2003 14:38:38 +0100
From: Matthew Wilcox <willy@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Wilcox <willy@debian.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
Subject: Re: [ACPI] ACPI blacklisting: move year blacklist into acpi/blacklist.c
Message-ID: <20031001133838.GM24824@parcelfarce.linux.theplanet.co.uk>
References: <20031001101826.GA3503@elf.ucw.cz> <20031001122412.GJ24824@parcelfarce.linux.theplanet.co.uk> <20031001133104.GA21626@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001133104.GA21626@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 03:31:04PM +0200, Pavel Machek wrote:
> > Why do they need to be externs?  The comp.lang.c FAQ suggests they don't
> > have to be.
> > 
> > http://www.eskimo.com/~scs/C-faq/q1.11.html
> 
> Well, they don't *have* to be there, but as FAQ says, it is stylistics
> hint.

I think "being in a .h file" is a sufficient hint ;-)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
