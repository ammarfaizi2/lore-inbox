Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291316AbSAaVRw>; Thu, 31 Jan 2002 16:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291317AbSAaVRm>; Thu, 31 Jan 2002 16:17:42 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:5641 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S291316AbSAaVRc>;
	Thu, 31 Jan 2002 16:17:32 -0500
Date: Thu, 31 Jan 2002 13:16:02 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Driver auditing
Message-ID: <20020131211602.GC1772@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 03 Jan 2002 15:09:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Well it seems that a few people noticed my previous message about
helping USB driver authors out, and took me up on it :)

So I might as well announce it to everyone.  I am glad to glance over
driver code, and try to help out with any issues that people have.  I'm
not guaranteeing to find all potential problems, and don't think that a
"looks good" from me holds any weight with anyone else, but if you want
to have someone to help look for stupid mistakes, style issues, and
other driver related things, feel free to take me up on it.

If I get buried in a ton of stuff, and find that all I'm doing is
auditing code, I'll stop it, but I know the value of a second pair of
eyes at times, and am glad to help out.

thanks,

greg k-h
