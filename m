Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTAWXyq>; Thu, 23 Jan 2003 18:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267421AbTAWXyq>; Thu, 23 Jan 2003 18:54:46 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:28033 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267267AbTAWXyp>;
	Thu, 23 Jan 2003 18:54:45 -0500
Date: Fri, 24 Jan 2003 00:00:40 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
Subject: Re: [PATCH] ACPI update (20030122)
Message-ID: <20030124000040.GB18596@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
References: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 02:44:55PM -0800, Grover, Andrew wrote:

 > The latest ACPI patch is now available at http://sf.net/projects/acpi .
 > Non-Linux packages will be available within 24 hours from
 > http://developer.intel.com/technology/iapc/acpi/downloads.htm .

I've noticed that with .59 some of my boxes no longer have
functioning NICs unless I boot with acpi=off. Packets get
transmitted, but nothing ever gets received.
Seen this with a 3c509, an 8139, and an e100.

Known bug? Fixed in this patch ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
