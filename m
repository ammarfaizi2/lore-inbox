Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270449AbTHJSDb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 14:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270496AbTHJSDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 14:03:31 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:26808 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S270449AbTHJSDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 14:03:30 -0400
Date: Sun, 10 Aug 2003 20:01:18 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: James Morris <jmorris@intercode.com.au>
Cc: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>,
       Fruhwirth Clemens <clemens-dated-1061346967.29a4@endorphin.org>,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, kernel@gozer.org,
       axboe@suse.de
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
Message-ID: <20030810200118.U639@nightmaster.csn.tu-chemnitz.de>
References: <20030810160706.5D083400211@mwinf0501.wanadoo.fr> <Mutt.LNX.4.44.0308110226530.8288-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Mutt.LNX.4.44.0308110226530.8288-100000@excalibur.intercode.com.au>; from jmorris@intercode.com.au on Mon, Aug 11, 2003 at 02:28:08AM +1000
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19luWt-0005Gh-00*33n09jd9ji6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 11, 2003 at 02:28:08AM +1000, James Morris wrote:
> On Sun, 10 Aug 2003, Pascal Brisset wrote:
> 
> > But I'd rather see a semantically correct reference implementation.
> Ok, please take into account the case where src == dst.

Cryptoloop takes this into account?

This would mean, that you finally have in-place encryption
available. Good move!

Regards

Ingo Oeser
