Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269536AbUICKB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269536AbUICKB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269617AbUICJ6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:58:21 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:54958 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S269620AbUICJyU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:54:20 -0400
Date: Fri, 3 Sep 2004 11:53:52 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <187829775.20040903115352@tnonline.net>
To: Bernd Petrovitsch <bernd@firmix.at>
CC: Steve Bergman <steve@rueb.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       reiserfs <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
In-Reply-To: <1094201383.1077.19.camel@tara.firmix.at>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain>
 <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com>
 <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
 <4136A14E.9010303@slaphack.com>
 <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
 <4136C876.5010806@namesys.com>
 <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
 <4136E0B6.4000705@namesys.com>  <14260000.1094149320@flay>
 <1094154744.12730.64.camel@voyager.localdomain>
 <16310213029.20040902220603@tnonline.net>
 <1094201383.1077.19.camel@tara.firmix.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> On Thu, 2004-09-02 at 22:06 +0200, Spam wrote:
> [...]
>>   The file streams would make my day a lot easier. The idea to
>>   split up contents of OO.org files into streams is bad. But that
>>   doesn't make the file streams bad. I see many uses that would make
>>   my every day life easier.

> When can we expect patches?

>>   It isn't about cross plat form compatibility, but to add features
>>   that are useful and meta-data and file streams are.

> Putting everything (including web server and browser) in the kernel is
> not a good (or even desireable) target - perhaps that's the reason for
> Win* to be where there are.
> And it *is* done in user-space (ok, there more than one apprach and
> implementation but this may change. And you want to invent the next
> version.).

  As I said before. It doesn't matter if it is in the kernel or user
  space. Not to me at least - as long as I could use extend the usage
  of my filesystem with meta-data, my own descriptions, perhaps
  streams, etc in a transparent way. I do not want to be confined to
  only use future Gnome apps.

>>   Also. No one forces you to use either meta-data or streams, just as
>>   no one forces you to use ACLs or other things.

> Which is probably an argument against such features. How long do ACLs
> exist - as well as standard and in implementation?
> How many people and/or apps are using it?
> No more questions.

>> > 3. MS does require attributes and multiple streams, which makes these
>> > features important (even essential) to Samba, and Samba alone.  Samba is
>> > important to Linux, so this can't be ignored. (Here I am implicitly
>> > assuming that Samba will need kernel support for this to do it right.)
>> 
>>   I do not think the Samba would really require the streams support
>>   but it would certainly make life easier for Samba. Not to mention
>>   that these files would also be natively viewed on the Linux host.

> It is not in the interest of MSFT that their aplication's files are
> viewable on other OSes. Expect incompatible changes to formats, streams
> and metadata contents (and surely patents on them - even if the idea is
> not new) if it starts to be really useful. It happended already in the
> past with the SMB protocol IIRC ....

  No perhaps. But it doesn't make a difference to the ideas of having
  plugins for reiser4 that can give such features.

  ~S

> 	Bernd

