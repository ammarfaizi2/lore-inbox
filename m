Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbQLHS0X>; Fri, 8 Dec 2000 13:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129786AbQLHS0N>; Fri, 8 Dec 2000 13:26:13 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:40711 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130146AbQLHS0D>; Fri, 8 Dec 2000 13:26:03 -0500
Date: Fri, 8 Dec 2000 11:50:59 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <20001208115059.A4817@vger.timpanogas.org>
In-Reply-To: <3A3066EC.3B657570@timpanogas.org> <E144O4d-0003vd-00@the-village.bc.nu> <20001208113340.B4730@vger.timpanogas.org> <3A311D95.A39E0241@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A311D95.A39E0241@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Dec 08, 2000 at 12:42:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 12:42:45PM -0500, Jeff Garzik wrote:
> "Jeff V. Merkey" wrote:
> 
> We don't need any messages.  If (DANGEROUS) is not sufficient, then
> disable the feature unconditionally.  Someone hacking on the code will
> be smart enough to enable the stuff while they are debugging.
> 
> 	Jeff
> 

You guys make the call.  I will be here to catch the 100+ messages that would
normally be posting to the kernel list with "Linux destroyed my data", and
I have been handling them.  I am just alerting you guys that the numbers
of people needing this are increasing, which is an indication more and more
people are using Linux to migrate NT to Linux, and vice-versa, and getting 
themselves into trouble.  We need to brainstorm a more long term solution
for this problem.  I suspect if I post these tools on our FTP server 
for free download, MS will promptly show up with attorneys.  Normally, this
is what I would do, but these tools were developed via access to MS IP,
and so long as I am helping MS customers recover data in a "consulting"
capacity, I do not believe they will interfere, particularly since 
everytime this happens, Linux gets a great big black eye with the 
affected customer.   But very soon (like after 2.4 ships) the numbers
of folks needing this may increase to a capacity I cannot support 
properly without dumping these tools into general distribution -- then
the shit will hit the fan with MS if I do this.  

:-)

Jeff

    
> -- 
> Jeff Garzik         |
> Building 1024       | These are not the J's you're lookin' for.
> MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
