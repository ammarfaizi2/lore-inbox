Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVFTTFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVFTTFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVFTTFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:05:10 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:51116 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261464AbVFTS5J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:57:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rWNAoWV4sEowfXDxFPwt+Vq1mVW13Etuq7bb4PE1B2j2CynzKBVVj0t0Ml6jNhIG8h0pDQ9UD34Vt/BtcqkFz13ce8lNuH36ISL38fyvaRIDm3ohj7N3dyV9FYgggw4iUalnvobKsqmz6Pk7IhIPRHFqIh2pL0/YKAyJGJPN248=
Message-ID: <84144f0205062011571a9d02d3@mail.gmail.com>
Date: Mon, 20 Jun 2005 21:57:04 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Lenz Grimmer <lenz@grimmer.com>
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <42B6F723.50808@grimmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620155720.GA22535@ucw.cz>
	 <005401c575b3$5f5bba90$600cc60a@amer.sykes.com>
	 <20050620163456.GA24111@ucw.cz> <42B6F723.50808@grimmer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/05, Lenz Grimmer <lenz@grimmer.com> wrote:
> On Windows, you need to run a separate tray application that enables the
> protection. So it seems like it's implemented in "userspace". It may be
> worth debugging what this Window applet actually does...

According to this [1], the mechanism can tell the difference between
harmful movements and repetitive motion which definitely suggests an
in driver (or userspace) statistics model based prediction.

P.S. I have a ThinkPad 41p or 42p at work. I am willing to help out if
it has the said device and we can get enough info on how to program
it.

                        Pekka

  1. http://www.anandtech.com/printarticle.aspx?i=1893
