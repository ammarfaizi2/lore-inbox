Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbUBYQaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUBYQUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:20:12 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:46739 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261406AbUBYQTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:19:38 -0500
Date: Wed, 25 Feb 2004 11:09:35 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: cryptoapi highmem bug
Message-ID: <20040225160935.GD4218@certainkey.com>
References: <1077655754.14858.0.camel@leto.cs.pocnet.net> <20040224223425.GA32286@certainkey.com> <1077663682.6493.1.camel@leto.cs.pocnet.net> <20040225043209.GA1179@certainkey.com> <20040224220030.13160197.akpm@osdl.org> <20040225153126.GA7395@leto.cs.pocnet.net> <20040225155121.GA7148@leto.cs.pocnet.net> <20040225154453.GB4218@certainkey.com> <1077725621.7221.0.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077725621.7221.0.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darn.

http://jlcooke.ca/lkml/crypto_24feb2004.patch will work.

JLC

On Wed, Feb 25, 2004 at 05:13:41PM +0100, Christophe Saout wrote:
> Am Mi, den 25.02.2004 schrieb Jean-Luc Cooke um 16:44:
> 
> > Could you make this change against my patch at:
> >   http://jlcooke.ca/lkml/crypto_28feb2004.patch
> 
> The link is broken.
> 

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
