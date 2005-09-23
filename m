Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVIWLhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVIWLhs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 07:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVIWLhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 07:37:48 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:8055 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750883AbVIWLhr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 07:37:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=troy+hoPN4LsZT3LIcvemIVJMEC6/ruyy9zCijUijBJZ9KvDkfE4zJKpjxl6d1saN1GJWWsEDK9FUBHSKh/e4jatVNiISPrSkAscLJ7U2eMPOa++b246Ffn+dotBMOcvCRml/0Nxq8TNUPKcXKzoh1yKmwJn9W/laCdHZmsUb8Y=
Message-ID: <e692861c05092304375542ec93@mail.gmail.com>
Date: Fri, 23 Sep 2005 07:37:46 -0400
From: Gregory Maxwell <gmaxwell@gmail.com>
Reply-To: Gregory Maxwell <gmaxwell@gmail.com>
To: David Greaves <david@dgreaves.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@suse.cz>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <43339EE5.9030202@dgreaves.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>
	 <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz>
	 <20050921000425.GF6179@thunk.org>
	 <e692861c05092018017ceef484@mail.gmail.com>
	 <43339EE5.9030202@dgreaves.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/05, David Greaves <david@dgreaves.com> wrote:
> who's not keeping up with the linux-raid list then ;)
>
> David
> PS I'm sure assistance would be appreciated in testing and reviewing
> this few day old feature - or indeed the newer 'add a new disk to the
> array' feature.

After posting that I checked linux-raid.... Thanked the author,
patched a box, but got called out of town before I could test
anything. :)

This is an important development. ... and it's about darn time!
