Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290568AbSARAiw>; Thu, 17 Jan 2002 19:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290570AbSARAin>; Thu, 17 Jan 2002 19:38:43 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:60897 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S290568AbSARAie>; Thu, 17 Jan 2002 19:38:34 -0500
Date: Fri, 18 Jan 2002 00:34:44 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: hashed waitqueues
Message-ID: <20020118003444.A3980@kushida.apsleyroad.org>
In-Reply-To: <20020104094049.A10326@holomorphy.com> <E16MeqE-0001Ea-00@starship.berlin> <20020104173923.B10391@holomorphy.com> <20020116142140.A31993@kushida.apsleyroad.org> <20020116094226.A760@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020116094226.A760@holomorphy.com>; from wli@holomorphy.com on Wed, Jan 16, 2002 at 09:42:26AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> Regardless, various arches want non-multiplicative hash functions and
> they'll be getting them. These hash functions will certainly prove
> useful in getting a broader base to test against. I don't care to have
> a "pet" hash function, only one that is good as possible.

Take a look at these too.  Not much information about how good they are,
but they do provide yet more examples to test, if you're testing.

http://www.physik.tu-muenchen.de/lehrstuehle/T32/matpack/html/LibDoc/Strings/strings.html

http://www.physik.tu-muenchen.de/lehrstuehle/T32/matpack/source/Strings/

-- Jamie
