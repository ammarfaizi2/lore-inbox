Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261563AbTCGNRY>; Fri, 7 Mar 2003 08:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbTCGNRY>; Fri, 7 Mar 2003 08:17:24 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:32692 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261563AbTCGNRX>; Fri, 7 Mar 2003 08:17:23 -0500
Date: Fri, 7 Mar 2003 13:25:26 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: gilson redrick <gilsonr@cityisp.net>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mandrake/AMD x L-2.5.xx
Message-ID: <20030307142518.GA18138@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	gilson redrick <gilsonr@cityisp.net>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <200303070752.31261.gilsonr@cityisp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303070752.31261.gilsonr@cityisp.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 07:52:31AM -0500, gilson redrick wrote:

 > All the software on my system is fairly new. In the case of gcc, I thought the 
 > v-3.2 might be an adverse factor, so I compiled and tried v-2.95.3; it made 
 > no difference. Likewise, I thought modutils-2.4.19 wasn't new enough, I 
 > installed the latest I could find, v-2.4.22-1, but it didn't help at all.

I doubt Mandrake ships the module-init-tools that the new style module
loader needs (only Debian currently does afaik). I suggest reading
http://www.codemonkey.org.uk/post-halloween-2.5.txt

		Dave

