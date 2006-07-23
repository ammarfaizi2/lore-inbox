Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWGWS0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWGWS0G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 14:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWGWS0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 14:26:06 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:14222 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751195AbWGWS0F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 14:26:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pnNd3VVFxjTcFXhg9uFJlXKrQXFo/Zeyii0gbcXB0TqpUTnObmCgjeBckAe2bYUzuHLbPcz28L6PCGM8CxcYlHG6mqZI5uB3ePx2zpcb85wJfottQq2H+tXoawbYNi2BHjQ54JPNG/Ir5xA42eDDHIh2uocsqNEzTUI3uAgOF8s=
Message-ID: <b8bf37780607231126u7e33a9dexcaa0d5a63dd6b356@mail.gmail.com>
Date: Sun, 23 Jul 2006 14:26:04 -0400
From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
To: "linux list" <linux-kernel@vger.kernel.org>
Subject: RE: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
In-Reply-To: <1153678231.044608.12610@i3g2000cwc.googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <6Ba6G-41w-3@gated-at.bofh.it> <6Bpp9-1XU-23@gated-at.bofh.it>
	 <6Bvuv-2Wa-11@gated-at.bofh.it> <6Bwqz-4m0-11@gated-at.bofh.it>
	 <1153678231.044608.12610@i3g2000cwc.googlegroups.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Hans Reiser wrote:
> > Theodore Tso wrote:
> >
> >> Actually, the first bits
> >>
> > yes, the first bits....   other people send in completed filesystems....
>
> Completed filesystems have a much higher barrier to entry, because they
> require a fresh review.
>
> ext4 will go upstream MUCH faster, because it follows the standard
> process of Linux evolution, building on top of existing code with
> progressive changes:

Hi, Hans!

    I think you are mostly right in your conclusions, it is sad but
true that we lose very good developers sometimes. I hope this
can be changed by emails like yours in the long run.

   I would like to see you and Christoph working again with synergy
(with harmony), but you have insulted him in the past. I regret this
happened and I think reiser4 would be already with us all if you had
focused at the technical discussion with him. I know that sometimes
it is difficult but we must all learn with Greg Kroah-Hartman, one of
the major contributors in volume to the kernel: be highly diplomatic
and respectfull. See more here:

    http://os.newsforge.com/os/06/07/23/1212252.shtml?tid=2&tid=138

    The arguments Jeff presented are super strong and are backed by an
entire past thread where Linus and others share a sharp clear vision
which I think that works very well in practice:

http://www.kernel-traffic.org/kernel-traffic/kt19991101_41.html#6

    They are _right_ (tm) here. We all know they are from our experiences
in past mistakes.

   I would like to thank you for reiser4, it is great! Please use your
diplomacy to get more reviews. After getting the code reviewed, fix the
complaints or discuss technically your POV.
   We all want reiser4 in (I do think it is great), but after reviewed by the
filesystem experts.

Thank you and the reiser4 team!

-- 
[]s,
André Goddard
