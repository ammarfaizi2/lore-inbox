Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVARSIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVARSIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 13:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVARSIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 13:08:21 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:9234 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261357AbVARSIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 13:08:19 -0500
Date: Tue, 18 Jan 2005 13:07:47 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [rfc] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050118180745.GA6883@tuxdriver.com>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <20050117183708.GD4348@tuxdriver.com> <20050117203930.GA9605@gondor.apana.org.au> <20050117214420.GH4348@tuxdriver.com> <20050117232323.GA21365@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117232323.GA21365@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 10:23:23AM +1100, Herbert Xu wrote:
> On Mon, Jan 17, 2005 at 04:44:22PM -0500, John W. Linville wrote:
> > 
> > Enemy Territory is available for free (as in beer) download from
 
> Sure, I don't mind trying it out :)
> 
> In the mean time, does this patch fix your problem as well?

Herbert,

No, that does not fix it. :-(  In fact, it doesn't seem to alter the
problem at all...

John
-- 
John W. Linville
linville@tuxdriver.com
