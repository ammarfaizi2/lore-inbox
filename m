Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277724AbRJROhm>; Thu, 18 Oct 2001 10:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277729AbRJROhd>; Thu, 18 Oct 2001 10:37:33 -0400
Received: from liszt-02.ednet.co.uk ([212.20.226.19]:61381 "HELO
	liszt-02.ednet.co.uk") by vger.kernel.org with SMTP
	id <S277725AbRJROhZ>; Thu, 18 Oct 2001 10:37:25 -0400
Subject: Re: Non-GPL modules
From: Martin Donnelly <md@uklinux.net>
To: "M. R. Brown" <mrbrown@0xd6.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011018090412.I22296@0xd6.org>
In-Reply-To: <Pine.LNX.3.95.1011018091343.32746A-100000@chaos.analogic.com> 
	<20011018090412.I22296@0xd6.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 18 Oct 2001 15:37:53 +0100
Message-Id: <1003415874.4004.45.camel@inchgower>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-18 at 15:04, M. R. Brown wrote:
>
> As far as EXPORT_MODULE_GPL is concerned, I think that's an excellent idea.
> There is *nothing* wrong with a copyright holder enforcing the fair use of
> his/her software, and I'd encourage all new GPL'd modules to start
> exporting these symbols.
>

It is a completely naive idea. You export some symbols as
EXPORT_MODULE_GPL(). I write a wrapper which is GPL'd but i don't export
my symbols as EXPORT_MODULE_GPL(), i now can interface to your code from
a proprietry module without breach of license through my wrapper with
very little work on my part. Your probably the same people who run about
using ROT13 as encryption.
 
> There are some of us who strive to keep the kernel as "pure" as possible,
> for a variety of reasons, the main one for me being peace of mind (knowing
> my code base is supported, and bugfixes are cheap).  Why is this so
> difficult for folks to grasp?
> 

That is you decision and you are free to have it, but don't try and
force it on other people by saying if you don't have a system running
100% GPL'd (or compatibly) licensed kernel - we reserve the right to
ignore any bugs you try and inform us about, regardless of whether or
not is is to do with the binary only module. It isn't exactly
encouraging.

Perhaps a less blunt tool could be used to encourage people to release
GPL compatibly licensed code for their previously binary modules? I
think you risk manufacturers withdrawing the support they have given by
saying if they don't release their code we won't support anything to do
with it. Carrots work better than sticks.

Cheers

Martin

-- 
A girl and a boy bump into each other -- surely an accident.
A girl and a boy bump and her handkerchief drops -- surely another
accident.
But when a girl gives a boy a dead squid -- *that had to mean
something*.
                -- S. Morganstern, "The Silent Gondoliers"

