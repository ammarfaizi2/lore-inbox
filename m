Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135856AbRDTK4D>; Fri, 20 Apr 2001 06:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135859AbRDTKzw>; Fri, 20 Apr 2001 06:55:52 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:12233 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135856AbRDTKzg>;
	Fri, 20 Apr 2001 06:55:36 -0400
Message-ID: <3AE0159D.DDC3C29B@mandrakesoft.com>
Date: Fri, 20 Apr 2001 06:55:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: starfire update for 2.4.4-pre5
In-Reply-To: <Pine.LNX.4.33.0104200322550.5165-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alas:
http://gtf.org/garzik/kernel/files/patches/2.4/2.4.4/net-version-2.4.4.5.patch.gz

To avoid all sync problems with me, you can always get the latest out of
my CVS.  CVS instructions on http://sourceforge.net/projects/gkernel/

Check out module 'linux_2_4'.  Branch name is based on the latest Linus
release: hack_2_4_4_pre5, hack_2_4_3, hack_2_4_2, etc.  Using the branch
name is critical: you cannot simply "cvs co linux_2_4" and have things
work.

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
