Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261488AbREVMkf>; Tue, 22 May 2001 08:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261471AbREVMk0>; Tue, 22 May 2001 08:40:26 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:22278 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261423AbREVMkI>; Tue, 22 May 2001 08:40:08 -0400
Date: Tue, 22 May 2001 14:39:38 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-ppp@vger.kernel.org
Subject: Re: ECN is on!
Message-ID: <20010522143938.L7958@arthur.ubicom.tudelft.nl>
In-Reply-To: <15114.18990.597124.656559@pizda.ninka.net> <Pine.LNX.4.30.0105220649530.17291-100000@biglinux.tccw.wku.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0105220649530.17291-100000@biglinux.tccw.wku.edu>; from brent@biglinux.tccw.wku.edu on Tue, May 22, 2001 at 06:51:57AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 06:51:57AM -0500, Brent D. Norris wrote:
> > I veto, the whole point of moving to ECN was to make a statement and
> > get people to fix their kit.
> >
> Isn't this a problem though because the messge saying that ECN was enabled
> was set after ECN was enabled?  Thus these people have no idea what is
> going on and they probably won't know what to fix until they do.

Not really, Dave Miller warned in advance that vger would enable ECN
Real Soon Now [tm]. If that wasn't a trigger for people to test if
their stuff could handle ECN, what does?


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
