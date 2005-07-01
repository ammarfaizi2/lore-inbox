Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263260AbVGAHE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbVGAHE0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbVGAHEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:04:21 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:25868 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263260AbVGAHDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:03:41 -0400
Message-ID: <42C4EACC.7020604@slaphack.com>
Date: Fri, 01 Jul 2005 02:03:40 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: "Theodore Ts'o" <tytso@mit.edu>, Markus T?rnqvist <mjt@nysv.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: backup (was Re: reiser4 plugins)
References: <42BB7B32.4010100@slaphack.com>	 <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl>	 <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org>	 <42C018E5.8030805@slaphack.com> <20050627162839.GA22799@thunk.org>	 <42C06BC6.7090002@slaphack.com> <20050630214950.GA14286@thunk.org> <d120d50005063015345a4968a@mail.gmail.com>
In-Reply-To: <d120d50005063015345a4968a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 6/30/05, Theodore Ts'o <tytso@mit.edu> wrote:
> 
>>On Mon, Jun 27, 2005 at 04:12:38PM -0500, David Masover wrote:
>>
>>>>    Streamload cannot warrant and does not guarantee, and You
>>>>    should not expect, that all of Your private communications and
>>>>    other personal information will never be disclosed in ways not
>>>>    otherwise described in this Privacy Policy.
>>>
>>>gpg.  Was in my upload script to begin with.  I keep my key written many
>>>times on a single hidden CD.  So long as the isofs can be read, at least
>>>one of the copies should be usable.
>>>
>>>They don't have any billing information on me.  If they charge me for
>>>something, I'll cancel my account.
>>
>>If you are using the free service, and are encrypting the data, you
>>are explicitly violating their terms of service, and they can delete
>>your data at any time, once they notice.
>>
> 
> 
> Does not look like it:
> 
> 3c. No encryption and/or steganography for the purpose of
> circumventing Streamload's rules.
> ... For example, if you'd like to encrypt something for an extra sense
> of security and privacy, please feel free to do so. However, when
> these tools are used solely for the purpose of circumventing
> Streamload's rules, as determined by the sole discretion of
> Streamload, the files will be deleted.

Trasnlation:  They really, honestly, have no way at all of knowing if my 
GPG-encrypted 450 meg tarball violates their terms.  They have legally 
given themselves the right to delete it just because they think it might 
violate their terms, but it wouldn't make sense for them to delete a 
file called "backup.tar.bz2.gpg" when there are no doubt a lot of other 
encrypted files on their servers.  It wouldn't make sense because they 
would either have to delete such files completely at random, or they'd 
have to delete all of them at once.

Further translation:  This was probably put here to keep the lawyers 
happy.  They don't want to be held liable for illegal stuff on their 
servers, for example, so they have at least spelled out, in legalese, 
that illegal stuff (and probably a few other categories) is not allowed 
on their servers, and that encyrpting it doesn't magically make it legal.

This kind of stuff makes lawyers happy, even if it *practically* does 
nothing at all.

Regardless, I feel reasonably safe with a backup there.  If I ever start 
to feel unsafe, I can always back up the most critical stuff to gmail, 
and create a few permanent copies on DVDs.  But I feel considerably 
safer with Streamload than with Gmail, because using Gmail for my own 
custom backup app directly violates their terms of service.

I think we should officially kill this particular thread.
