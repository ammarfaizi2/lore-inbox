Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbSBDSp7>; Mon, 4 Feb 2002 13:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbSBDSpu>; Mon, 4 Feb 2002 13:45:50 -0500
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:6922 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S280588AbSBDSpd>;
	Mon, 4 Feb 2002 13:45:33 -0500
From: "Tim Pepper" <tpepper@vato.org>
Date: Mon, 4 Feb 2002 10:45:25 -0800
To: Alexander Sandler <ASandler@store-age.com>, arjan@fenrus.demon.nl
Cc: "Linux Kernel Mailing List \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17: Bug?
Message-ID: <20020204104525.A30033@vato.org>
In-Reply-To: <BDE817654148D51189AC00306E063AAE054620@exchange.store-age.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BDE817654148D51189AC00306E063AAE054620@exchange.store-age.com>; from ASandler@store-age.com on Mon, Feb 04, 2002 at 11:12:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04 Feb at 11:12:27 +0200 ASandler@store-age.com done said:
> No no no no.
> 
> This is a bug. For me, it took two hours to get released
> from that. There is no such thing two hours timeout.
> And who said this is only two hours? I spoke with Arjan van de Ven
> and he told me that it may take for up to 14 hours.
> 
> Anyway, Arjan told me that he fixed this bug in the version that
> will be out with 2.4.18.

We're talking about different things.  Looking at the original post I see
I missed that the concern was the hung process not the "long" error retry.

Anybody have a link to what Arjan fixed?  I used to have occasional hangs like
this but they seemed to have gone away with qlogic's latest (4.46.12beta)
driver.

t.

-- 
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************
