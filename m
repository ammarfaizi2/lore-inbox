Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289647AbSAOU0a>; Tue, 15 Jan 2002 15:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290270AbSAOU0W>; Tue, 15 Jan 2002 15:26:22 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:34821 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289646AbSAOUZ0>; Tue, 15 Jan 2002 15:25:26 -0500
Date: Tue, 15 Jan 2002 20:25:18 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020115202518.G1822@flint.arm.linux.org.uk>
In-Reply-To: <20020115145324.A5772@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020115145324.A5772@thyrsus.com>; from esr@thyrsus.com on Tue, Jan 15, 2002 at 02:53:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 02:53:24PM -0500, Eric S. Raymond wrote:
> 	* The `vitality' flag is gone from the language.  Instead, the 
> 	  autoprober detects the type of your root filesystem and forces
> 	  its symbol to Y.

This seems like a backwards step.  What's the reasoning for breaking the
ability to configure the kernel for a completely different machine to the
one that you're running the configuration/build on?

Answers including Aunt Tillies or Penelopes won't be accepted. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

