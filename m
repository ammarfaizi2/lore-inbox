Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263257AbREaWw6>; Thu, 31 May 2001 18:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263268AbREaWws>; Thu, 31 May 2001 18:52:48 -0400
Received: from beaker.bluetopia.net ([63.219.235.110]:35356 "EHLO
	beaker.bluetopia.net") by vger.kernel.org with ESMTP
	id <S263257AbREaWwl>; Thu, 31 May 2001 18:52:41 -0400
Date: Thu, 31 May 2001 18:52:23 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
To: Pavel Roskin <proski@gnu.org>
cc: James Simmons <jsimmons@transvirtual.com>, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard optional on i386?
In-Reply-To: <Pine.LNX.4.33.0105290021420.12495-100000@portland.hansa.lan>
Message-ID: <Pine.LNX.4.04.10105311822560.1601-100000@beaker.bluetopia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001, Pavel Roskin wrote:
>> You can a few nice tricks with it like plug in two PS/2 keyboards. I
>> have this for my home setup. The only thing is make sure you don't
>> have both keyboards plugged in when you turn your PC on. I found BIOS
>> get confused by two PS/2 keyboards. As you can it is very easy to
>> multiplex many keyboards with the above design. I have had 4 different
>> keyboards hooked up to my system and functioning at the same time. We
>> even got a Sun keyboard to work on a intel box :-)
>
>That's what we like Linux for. It doesn't get confused when everything
>else does :-)

Heh, that's funny.  I must admit I'd never thought of that.

Anyway, the bios gets confused because it's trying to figure out (in a very
simple way) where the keyboard and mouse are.  It's true there's lots of
voodoo in PC BIOSes; keyboard/mouse detection isn't one of them.

(As I recall, I have to have something in the port to get it enabled.  Linux
 doesn't seem to know how to enable it.)

--Ricky


