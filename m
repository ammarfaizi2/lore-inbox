Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291649AbSBHRCu>; Fri, 8 Feb 2002 12:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291651AbSBHRCk>; Fri, 8 Feb 2002 12:02:40 -0500
Received: from ns.suse.de ([213.95.15.193]:38926 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291649AbSBHRC1>;
	Fri, 8 Feb 2002 12:02:27 -0500
Date: Fri, 8 Feb 2002 18:02:16 +0100
From: Dave Jones <davej@suse.de>
To: Andreas Happe <andreashappe@subdimension.com>
Cc: lkml <linux-kernel@vger.kernel.org>, green@namesys.com
Subject: Re: boot problems using 2.5.3-dj3 || -dj4
Message-ID: <20020208180216.H32413@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andreas Happe <andreashappe@subdimension.com>,
	lkml <linux-kernel@vger.kernel.org>, green@namesys.com
In-Reply-To: <000c01c1b0bf$567ab910$704e2e3e@angband>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000c01c1b0bf$567ab910$704e2e3e@angband>; from andreashappe@gmx.net on Fri, Feb 08, 2002 at 05:40:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 05:40:35PM +0100, Andreas Happe wrote:
 > From: "Andreas Happe" <andreashappe@gmx.net>
 > 
 > > With dj4 the computer generates a kernel - oops instead of just freezing.
 > 
 > sorry, with dj4 modprobe dies with the error message
 > "PAP-14030: direct2indirect: posted or inserted byte exists in the
 > treeinvalid operand: 0000"

 Ok, that's one for Oleg & Co to take a look at.
 Can you run the oops dump through ksymoops ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
