Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUENQD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUENQD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUENQD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:03:58 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:18340 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261628AbUENQCU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:02:20 -0400
Subject: Re: [PATCH] capabilites, take 2
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, olaf+list.linux-kernel@olafdietsche.de,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <40A4EC72.2020209@myrealbox.com>
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <fa.mu5rj3d.24gtbp@ifi.uio.no>
	 <40A4EC72.2020209@myrealbox.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1084550518.17741.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 14 May 2004 12:01:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-14 at 11:57, Andy Lutomirski wrote:
> Thanks -- turning brain back on, SELinux is obviously better than any
> fine-grained capability scheme I can imagine.
> 
> So unless anyone convinces me you're wrong, I'll stick with just
> fixing up capabilities to work without making them finer-grained.

Great, thanks.  Fixing capabilities to work is definitely useful and
desirable.  Significantly expanding them in any manner is a poor use of
limited resources, IMHO; I'd much rather see people work on applying
SELinux to the problem and solving it more effectively for the future.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

