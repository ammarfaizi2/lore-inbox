Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316797AbSFJJuu>; Mon, 10 Jun 2002 05:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316799AbSFJJut>; Mon, 10 Jun 2002 05:50:49 -0400
Received: from melpomene.ncsl.nist.gov ([129.6.57.175]:45706 "EHLO
	melpomene.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S316797AbSFJJus>; Mon, 10 Jun 2002 05:50:48 -0400
Date: Mon, 10 Jun 2002 05:50:49 -0400
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: MTU discovery
Message-ID: <20020610055049.A30121@melpomene.ncsl.nist.gov>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020610074507.69402.qmail@web21301.mail.yahoo.com> <20020610110513.I18899@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 11:05:13AM +0300, Matti Aarnio wrote:
>   Some devices do, however, support reception (and transmit) of what
>   is called "jumbograms".  With boomerang you can set a register
>   to contain the limit value.  Alternatively with boomerang, and
>   its predecessors, you can set a bit to accept extra-large frames.
> 
>   I recall the ultimate limit is in order of 4kB.

Actually, in my experience jumbograms are usually 9000 bytes.

  OG.

