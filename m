Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314124AbSDLRlU>; Fri, 12 Apr 2002 13:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314126AbSDLRlT>; Fri, 12 Apr 2002 13:41:19 -0400
Received: from www.soccerchix.org ([64.23.60.113]:41227 "EHLO
	gib.soccerchix.org") by vger.kernel.org with ESMTP
	id <S314125AbSDLRlT>; Fri, 12 Apr 2002 13:41:19 -0400
Date: Fri, 12 Apr 2002 13:06:18 -0400 (EDT)
From: Blue Lang <blue@b-side.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Michael De Nil <linux@aerythmic.be>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: i830M video chip (X driver deficient)
In-Reply-To: <m18z7tl642.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.30.0204121305430.17120-100000@gib.soccerchix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Apr 2002, Eric W. Biederman wrote:

> It isn't memory related at all.  The problem is that the X driver uses
> the video BIOS to set the display modes, instead of setting the
> display mode by itself as it should.  I don't know if there are enough
> docs available from intel about this but that is the problem.

erm.. I thought that's what I said. Anyways, here is that link I was
talking about:

http://www.cse.unsw.edu.au/~chak/linux/c400.html

Good luck,

-- 
Blue Lang                                      http://www.b-side.org/~blue
           editor, b-side.org                        http://www.b-side.org
           bug generation unit, alanthia mud             alanthia.org 1536
           integration engineer, veritas software   http://www.veritas.com

