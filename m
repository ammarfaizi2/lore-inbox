Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292395AbSBYXWJ>; Mon, 25 Feb 2002 18:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292396AbSBYXV7>; Mon, 25 Feb 2002 18:21:59 -0500
Received: from flaxian.hitnet.RWTH-Aachen.DE ([137.226.181.79]:41231 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S292395AbSBYXVu>;
	Mon, 25 Feb 2002 18:21:50 -0500
Date: Tue, 26 Feb 2002 00:21:49 +0100
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
Message-ID: <20020225232149.GA13480@gondor.com>
In-Reply-To: <20020225.140851.31656207.davem@redhat.com> <3C7AB893.4090800@ellinger.de> <20020225230156.GA11786@merlin.emma.line.org> <20020225.150813.66161624.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020225.150813.66161624.davem@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 03:08:13PM -0800, David S. Miller wrote:
> I repeat: it isn't a "release candidate" if it will not match preciely
> what the final tarball/patches contains.  Anything else opens up the
> possibility for errors to be made.

If the release candidates had identical version numbers, Marcelo could
still copy rc3 to final instead of rc4. So this doesn't solve anything,
it only adds some potential for confusion.

Release candidates only help if people use them and report errors. And
people who run rc kernels want to be able to use uname to find out which
kernel version is running.

So please keep EXTRAVERSION. 

Jan

