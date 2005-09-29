Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVI2X16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVI2X16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVI2X16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:27:58 -0400
Received: from qproxy.gmail.com ([72.14.204.204]:17269 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751365AbVI2X16 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:27:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cTMmMGMop9PBbgiSXasJsqffgkLtYlRXsoPosCIpk2p1uYVWXFYwhTArAAkUEyOi94c6Lo9GyYZbSmhyyG6vWQswmwScOiYXL4WiaaO3yP/DELwUue3YPtdppmlhtsnAK+1OPlrc8XBWQseuSouj4KKRiIrK2rR6AZb7aGhC6o0=
Message-ID: <6bffcb0e0509291627558cbac7@mail.gmail.com>
Date: Fri, 30 Sep 2005 01:27:56 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: 2.6.14-rc2-mm2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <433C765D.9020205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050929143732.59d22569.akpm@osdl.org>
	 <6bffcb0e05092915472f8589eb@mail.gmail.com>
	 <433C765D.9020205@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/09/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Michal Piotrowski wrote:
> > Hi,
> >
> > On 29/09/05, Andrew Morton <akpm@osdl.org> wrote:
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/
> >>
> >> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
> >
> > VESA VGA graphics support doesn't work with nvidia card (black
> > screen). (I know there is nvidia frame buffer support, but VESA VGA
> > works for me on current git).
> >
> > #
> > # Console display driver support
> > #
> > CONFIG_VGA_CONSOLE=y
> > CONFIG_DUMMY_CONSOLE=y
> > # CONFIG_FRAMEBUFFER_CONSOLE is not set
>
> Set this to y.
>
> Tony
>

ups... sorry my big mistake ;).

Regards,
Michal Piotrowski
