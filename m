Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVFZIBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVFZIBN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 04:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVFZIBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 04:01:13 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:52748 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261492AbVFZIAq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 04:00:46 -0400
Message-ID: <42BE60AC.9090604@slaphack.com>
Date: Sun, 26 Jun 2005 03:00:44 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
Cc: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>            <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <42BE3A90.1090403@slaphack.com> <42BE5492.4030903@cisco.com>
In-Reply-To: <42BE5492.4030903@cisco.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Lincoln Dale wrote:
> David Masover wrote:
> 
>> Ok, I'll bite.  Hans put it best a moment ago:
>>  
>>
> [..]
> 
> you seem to have some misconceived notion that this is somehow a
> "ReiserFS versus XFS" or "ReiserFS versus ext3" case.
> l-k could do without those conspiracy theories.  lets just stick to the
> facts.

erm, let me take a peek at what you just chopped out.

Yeah.  Um.  I mention XFS and ext3 *once* in the whole message.  As an
example of filesystems in general, because the only other two I'd
consider (or ever use) for a desktop FS at this point is XFS or ext3.
And it was a hypothetical opinion (I don't really know if / how much
Hans feels that way), and I personally find it far easier to believe
that there are stubborn people or that there isn't enough communication
of facts than that there is actually some anti-reiser conspiracy.

So, my mistake for trying to speak for other people.

>> No, as a user, I just want a working plugin architecture to play with
>> (I'm not *just* a user), and a working Reiser4 'cause it's fast, and I
>> am eager to see new improvements coming out of Namesys, instead of two
>> years spent trying to keep up with the vanilla kernel *and* adapt to
>> some unspecified, possibly unneccessary, decree of a benevolent dictator.

[...]
> but just don't have the false expectation that just because something is
> 'kool' that its going to get into the kernel without rigorous peer
> review & approval

I don't, actually.

I did expect the peer review to be a little more efficient, less
confrontational, and (maybe) more fair.  But I'm actually a bit content
right now.  After all, I *am* running reiser4 on two of the three
machines I maintain at home.

And, if you scroll up a bit, at this point I just want this resolved.  I
don't particularly care if Hans decides to just keep maintaining a
patchset, although I would be happier if it got into the mainstream
kernel -- I wouldn't have to wait as long to install each new 2.6.11 or
2.6.12 + nvidia module.

But this is a lot of time and energy from a lot of people on both sides
who I would rather see working on something else.

I appologize for the tone of that, too.  I know you don't work for me...

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr5gq3gHNmZLgCUhAQLgixAAgC1WTVa8+6wP3CbCJafz4V5+f/hcJkuG
xtXeh/CPvN4FzRRu+UjDVgji6yrLQ9AxFOa9kg9iJzZLIDDUNKu6UvFe+j22Mmpv
F/24aLD8NAtF4JNGOJv6xFZtwk03N8Q92+CU0b5jPEViom2h55OkKfSIzoGz47Ee
45XGDx0v2LCHVG+HhVuG3EVQNjI4oBiwQteErHjmoNcvh7npkbdYGvEHRULgX3rO
eCals0WPCQ+A10xDoTll6NvqEU59aHeheDw+FBkCZw4GhGaSCdZn0q8EHqqTdufL
iU5z/Q6J98KvjeMdhlCW8QRWA+hSIwQJcn+09IzI2lT4QnpPDRTeX3NxsdCrVbLu
fg37+d46cfWNrXpIrm3SoaTMl5GGvGGTekD46deTtotbJ40fSXGv3FbB6KCFK04s
U6kjfnqO8fFG/iKWExCqts6HUPiboI/zpz8w/oL7XudJO/jxKavKQGk+POCFquyT
U2e7KvZig5Ct0aunlIec7NrrRbutfYU6TFlYYRlV6XmIDP29ZDtqN9DsIBEvSeP5
7RFs4r0nTaIj17mpWmX5XCaLGNSUqzsQ1bzIoAl/D8NzbRTD9dsukvZyz5lW7tiZ
zsWe4mHtJrZ1/mQf/oCj36FXID+bd3xN0WGIjli5gzMjCK8uCkS09MQ+JeLGQHES
M/wMDcMcrwE=
=3y4o
-----END PGP SIGNATURE-----
