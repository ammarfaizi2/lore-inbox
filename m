Return-Path: <linux-kernel-owner+w=401wt.eu-S932319AbWLPE7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWLPE7z (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 23:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWLPE7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 23:59:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:32408 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319AbWLPE7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 23:59:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bZZMV8cg+xjNPFoqpjiv/fdf0PJgn7zqbRh9ZiKnEDupiG5dkQ58c3tpoggPQT5JOQCnDxCsrHHshMsOBabknHxo8BvVEOB2OjfhWVAedeWq6+mLF8IG6VV2eeA9VyblbkOVEL8CHw09uy1pHPAyIOYQ0VXFoXMHLhkdVtwapW4=
Message-ID: <21d7e9970612152059j73a74b97kaa44d40f62684fb9@mail.gmail.com>
Date: Sat, 16 Dec 2006 15:59:52 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: jdow <jdow@earthlink.net>
Subject: Re: Binary Drivers
Cc: "Alexey Dobriyan" <adobriyan@gmail.com>,
       "James Porter" <jameslporter@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <056f01c720c6$201a0ca0$0225a8c0@wednesday>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <loom.20061215T220806-362@post.gmane.org>
	 <20061215220117.GA24819@martell.zuzino.mipt.ru>
	 <056f01c720c6$201a0ca0$0225a8c0@wednesday>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/06, jdow <jdow@earthlink.net> wrote:
> From: "Alexey Dobriyan" <adobriyan@gmail.com>
>
> > On Fri, Dec 15, 2006 at 09:20:58PM +0000, James Porter wrote:
> >> I think some kernel developers take to much responsibility, is there a
> >> bug in a
> >> binary driver? Send it upstream and explain to the user that it's a
> >> closed
> >> source driver and is up to said company to fix it.
> >>
> >> For what it's worth, I don't see any problem with binary drivers from
> >> hardware
> >> manufacturers.
> >
> > Binary drivers from hardware manufacturers are crap. Learn it by heart.
>
> So are the Linux drivers in some cases. My ATI Radeon Mobility video
> in my laptop is an example.
>

Open drivers aren't magic.. if the vendor doesn't give us the
information how specific chips are screwed, there isn't anything we
can do about it, ATI don't support the open drivers for anything but
RN50s from Dell and their support is quite brutal even on those (every
patch is a dirty hack...), the thing is with the open drivers we can
say hey ATI that is a dirty hack, with the closed ones they just stick
it in and ship it..

Dave.
