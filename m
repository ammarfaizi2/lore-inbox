Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbRFGP1U>; Thu, 7 Jun 2001 11:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbRFGP1K>; Thu, 7 Jun 2001 11:27:10 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:24047 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S261502AbRFGP1B>;
	Thu, 7 Jun 2001 11:27:01 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table 
In-Reply-To: Your message of "Thu, 07 Jun 2001 11:05:07 +0100."
             <20010607110507.A1765@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Jun 2001 01:27:39 +1000
Message-ID: <3397.991927659@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2001 11:05:07 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>Umm, any commercial company can come along and re-implement any part of
>the Linux kernel, produce a distribution or supply kernel binary images
>as long as they make available the source code to the people they
>supply the kernel binary to, and no more.

GNU General Public License Version 2, June 1991.  Section 3(b) says
"any third party", not just customers.

Nothing in the GPL restricts the source being supplied to "the people
they supply the kernel binary to, and no more".  Even if a company
refused to supply their source changes to anybody except a customer
(which would violate the GPL anyway), section 2(b) explictly allows
those customers to give the source to anybody.  Attempts to restrict
distribution will void your rights under the GPL, see section 4.

