Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVCVDAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVCVDAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVCVC7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:59:46 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:60000 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262269AbVCVC7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:59:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FkCATquLNAviKoVpHkheZ+wbE/WgN+IXvRu0XwmuzFGhN+UneCOvO6biQA606t7DkDRhuW2b7YmWGFXItst2+M+g+W3kNhP9YMBZkg5tWna7Ry9wrZVpDwseojDuxTVhE1H57mlnF3xkNrg/wo1/s7sPVKybI+B2ujXQPb/543M=
Message-ID: <a44ae5cd050321185947448028@mail.gmail.com>
Date: Mon, 21 Mar 2005 21:59:05 -0500
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Who should I write to about this OOPS in 2,6,11-mm3?
Cc: linux-kernel@vger.kernel.org, LM Sensors <sensors@stimpy.netroedge.com>
In-Reply-To: <20050321184011.78808b8d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <a44ae5cd05031416392e3addd5@mail.gmail.com>
	 <200503180702.42247.adaplas@hotpop.com>
	 <20050317154226.24c1f8f8.akpm@osdl.org>
	 <200503180754.21258.adaplas@hotpop.com>
	 <20050321184011.78808b8d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I just did.  I used the .config options I mentioned earlier.  I
am currently testing the suggested patches and options offered by the
sensors developers.

BTW, I am cross posting because I am not sure how often the LM Sensors
folks read the linux-kernel list.  Please don't reply to both lists.

    Miles


On Mon, 21 Mar 2005 18:40:11 -0800, Andrew Morton <akpm@osdl.org> wrote:
> "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> >
> > FYI, the original topic of this thread, though, was an oops in
> >  i2c_add_driver() as mentioned in this thread:
> >
> >  http://marc.theaimsgroup.com/?l=linux-kernel&m=111076667232062&w=2
> >
> >  Unfortunately, nobody can reproduce this oops.
> 
> Miles, are you still able to reproduce the i2c_add_driver() oops in
> 2.6.12-rc1 or 2.6.12-rc1-mm1?
> 
> Thanks.
>
