Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVCVD5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVCVD5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVCVDzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 22:55:03 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:11884 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262246AbVCVDtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 22:49:17 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: 2.6.11.4 vaio z1xmp mouse click
Date: Mon, 21 Mar 2005 22:20:44 -0500
User-Agent: KMail/1.7.2
Cc: dmitry.torokhov@gmail.com, dave.m@email.it, linux-kernel@vger.kernel.org
References: <200503141916.30252.dave.m@email.it> <d120d500050318073671f15ad6@mail.gmail.com> <20050321175707.2e0befb1.akpm@osdl.org>
In-Reply-To: <20050321175707.2e0befb1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503212220.45162.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 20:57, Andrew Morton wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >
> > On Mon, 14 Mar 2005 19:16:29 +0100, dave <dave.m@email.it> wrote:
> > > 
> > > hy,
> > > 
> > > Upgrading kernel from Linux 2.6.10 (full) to 2.6.11.4(full) the left mouse
> > > click get losed (I can not clik).
> > 
> > Is your touchpad being detected as an ALPS touchpad? There are some
> > issues with tapping that should be fixed in 2.6.12. In the meantime
> > you could try 2.6.11-mm or force PS/2 compatinbility mode by bootintg
> > with psmouse.proto=exps on kernel command line.
> 
> Did we hear back from Dave on this?
> 

Not yet...

-- 
Dmitry
