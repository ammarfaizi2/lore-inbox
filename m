Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRLBKbI>; Sun, 2 Dec 2001 05:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRLBKaz>; Sun, 2 Dec 2001 05:30:55 -0500
Received: from [193.252.19.61] ([193.252.19.61]:59875 "EHLO
	mel-rta7.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S274862AbRLBKal>; Sun, 2 Dec 2001 05:30:41 -0500
Message-ID: <3C0A025C.88B7A2C3@wanadoo.fr>
Date: Sun, 02 Dec 2001 11:28:44 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre5 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
				<9u9qas$1eo$1@penguin.transmeta.com>
				<200112010701.fB171N824084@vindaloo.ras.ucalgary.ca>
				<3C0898AD.FED8EF4A@wanadoo.fr>
				<200112011836.fB1IaxY31897@vindaloo.ras.ucalgary.ca>
				<3C093F86.DA02646D@wanadoo.fr> <200112012320.fB1NKro03024@vindaloo.ras.ucalgary.ca> <3C097FB2.7A376199@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet wrote:
> 
> Richard Gooch wrote:
> 
> 
> > I assume if you use kernel 2.4.16 with devfsd-1.3.20 that there is no
> > Oops?

> > Finally, please try kernel 2.4.17-pre1, which has the latest version
> > of devfs. The 2.5.1-pre kernels have a lot of new experimental code

Here is the final (i hope) verdict of my devfs testbox :

2.4.16 with devfsd-1.3.18/1.3.20 : OK
2.4.17-pre1         "            : Broken
2.5.1-pre1          "            : OK
2.5.1-pre2 with or without v200  : Broken
2.5.1-pre5          "            : Broken

Pierre
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
