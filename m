Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWFRWlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWFRWlM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 18:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWFRWlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 18:41:12 -0400
Received: from mailfe12.tele2.fr ([212.247.155.108]:40668 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751046AbWFRWlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 18:41:10 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Mon, 19 Jun 2006 00:40:51 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060618224051.GE4744@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <20060618223906.GA30726@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060618223906.GA30726@animx.eu.org>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner, le Sun 18 Jun 2006 18:39:06 -0400, a écrit :
> why not only set this if the shell is /bin/sh ?

Because you can't know that. /bin/sh is one example of shell, /bin/ash
is another /usr/bin/myprog is yet another...

Samuel
