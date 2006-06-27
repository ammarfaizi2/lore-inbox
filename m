Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWF0OHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWF0OHH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWF0OHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:07:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:16755 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932284AbWF0OHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:07:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qe+2UmkqUzgglgZfhNgzYkDTsPTKJJ8SJ5YZOJG1Is5IIzQVRLsIXW9uq+yy/om/hhQyfspupM2je2Cnhvm6CKkpkW2+1eEsnjCopVaUvmFGUaMX9VBiwgz74dXRM4QZOq3jhkKRN/28DcfyXBAluh/RAj7VBQkyNrgtkcvl9Po=
Message-ID: <9e4733910606270707h1766bf6bw3c2c96e29db84d91@mail.gmail.com>
Date: Tue, 27 Jun 2006 10:07:04 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Roman Zippel" <zippel@linux-m68k.org>
Subject: Re: [klibc] klibc and what's the next step?
Cc: "H. Peter Anvin" <hpa@zytor.com>, torvalds@osdl.org, klibc@zytor.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606271316220.17704@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <klibc.200606251757.00@tazenda.hos.anvin.org>
	 <Pine.LNX.4.64.0606271316220.17704@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/06, Jeff Garzik <jeff@garzik.org> wrote:
> Roman Zippel wrote:
> > What I'm more interested in is basically answering the question and where
> > I hope to provoke a bit broader discussion: "What's next?"

POSTing of secondary video cards at boot is a good application for it.
Another is setting an initial mode on undocumented video hardware
where the only documented interface is in user space.

POSTing needs emu86 so that it will work on all platforms, where
should emu86 go?

-- 
Jon Smirl
jonsmirl@gmail.com
