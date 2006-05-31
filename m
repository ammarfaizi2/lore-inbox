Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbWEaEjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWEaEjV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWEaEjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:39:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:276 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751679AbWEaEjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:39:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dRDVaE1JIUhe6rbwcwH6ywSdka1+xa+T2WWu7dRLJ2cuNcJlrHH5gC4jtVUnnK7ey/JBt4oQNLTFcl1NSENbv6KrnEE4NS0M2cMhD5Bgx8ndna+gYgNL/pM2ZbgMUDULaXQJjbgFy04Nb7IkKMMw+CAC51ndrrW3O+AZ6I4NCi8=
Message-ID: <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
Date: Wed, 31 May 2006 00:39:19 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Dave Airlie" <airlied@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <200605310026.01610.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605302314.25957.dhazelton@enter.net>
	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
	 <200605310026.01610.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, D. Hazelton <dhazelton@enter.net> wrote:
> On Wednesday 31 May 2006 04:16, Jon Smirl wrote:
> > On 5/30/06, D. Hazelton <dhazelton@enter.net> wrote:
> > > Like I've said, this has gone onto my list. Now to get back to the
> > > code... I really do want to see about getting this stuff into the kernel
> > > ASAP.
> >
> > You might want to leave the DRM hot potato alone for a while and just
> > work on fbdev. Fbdev is smaller and it is easier to get changes
> > accepted.
>
> Yes, but I have accepted that there is a certain direction and order the
> maintainers want things done in. For this reason I can't just leave DRM
> alone.

fbdev (Antonino A. Daplas <adaplas@gmail.com>) and DRM (Dave Airlie
<airlied@gmail.com>) have two different maintainers. I have not seen
Tony comment on what he thinks of Dave's plans so I don't know what
his position is how driver merging can be acomplished.

-- 
Jon Smirl
jonsmirl@gmail.com
