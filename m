Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265821AbTFVTQc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 15:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265824AbTFVTQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 15:16:31 -0400
Received: from RJ088138.user.veloxzone.com.br ([200.141.88.138]:32896 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id S265821AbTFVTQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 15:16:31 -0400
Date: Sun, 22 Jun 2003 16:30:32 -0300 (BRT)
From: =?UTF-8?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RESEND] 2.4 devfs deadlock on concurrent lookups on
 non-existent entry
Message-ID: <Pine.LNX.4.56.0306221625520.181@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:

> Unfortunately, I do not know who is current active devfs
> maintainer.

I thought it was Richard Gooch. When 2.4.20 was released I
asked him if I could apply the latest patch from
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/
. 2.4.21 was released, but again without the 199.17 patch.
Anything wrong with it or nobody submitted it to Marcelo ?
