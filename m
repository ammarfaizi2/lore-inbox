Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268088AbUIFO7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUIFO7k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 10:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268094AbUIFO7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 10:59:40 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:15590 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268088AbUIFO7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 10:59:34 -0400
Date: Mon, 6 Sep 2004 16:59:23 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <164628888.20040906165923@tnonline.net>
To: Tonnerre <tonnerre@thundrix.ch>
CC: Valdis.Kletnieks@vt.edu, Frank van Maarseveen <frankvm@xs4all.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
In-Reply-To: <20040906144358.GC29886@thundrix.ch>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain>
 <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus>
 <200409022319.i82NJlTN025039@turing-police.cc.vt.edu>
 <1076230617.20040903014302@tnonline.net> <20040906144358.GC29886@thundrix.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Salut,

> On Fri, Sep 03, 2004 at 01:43:02AM +0200, Spam wrote:
>>   Yes why not? If there was any filesystem drivers for the AudioCD
>>   format then it could.
>> 
>>   I had such a driver for Windows 9x which would display several
>>   folders and files for inserted AudioCD's:
>> 
>>   D: (cdrom)
>>     Stereo
>>       22050
>>         Track01.wav
>>         Track02.wav
>>         ...
>>       44100
>>         Track01.wav
>>         ...
>>     Mono
>>       22050
>>         Track01.wav
>>         ...
>>       44100
>>         Track01.wav
>>         ...

> So you'd like the kernel to know  about raw CD PCM and RIFF PCM format
> and conversion? Great.. That's really Solarisish!

  If it could be done in userland, and still be accessible for most
  applications then that is great.

  If the user things that such a plugin is of value for him then I do
  not see why he should not be able to use it? Again these are example
  of stuff that could be done if there was a plugin/extensible
  interface.

  You make it sound like everything on the planet should be predefined
  and included in the kernel. This is not what I was saying or wanted.

  From what I understood from Hans, there will be a way to load
  plugins without having to recompile reiser4 module (or the kernel).
  This is what I'd like to see.

  Some things/plugins may even be partially user-space.

  ~S

  

> 			    Tonnerre


