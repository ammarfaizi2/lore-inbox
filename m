Return-Path: <linux-kernel-owner+w=401wt.eu-S1750784AbXACNzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbXACNzA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 08:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbXACNzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 08:55:00 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:55068 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbXACNy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 08:54:59 -0500
Date: Wed, 3 Jan 2007 06:54:55 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, bhalevy@panasas.com, arjan@infradead.org,
       mikulas@artax.karlin.mff.cuni.cz, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
Message-ID: <20070103135455.GA24620@parisc-linux.org>
References: <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org> <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu> <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu> <20070103115632.GA3062@elf.ucw.cz> <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 01:33:31PM +0100, Miklos Szeredi wrote:
> High probability is all you have.  Cosmic radiation hitting your
> computer will more likly cause problems, than colliding 64bit inode
> numbers ;)

Some of us have machines designed to cope with cosmic rays, and would be
unimpressed with a decrease in reliability.
