Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbVHOKdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbVHOKdG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 06:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVHOKdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 06:33:06 -0400
Received: from mirapoint5.brutele.be ([212.68.199.150]:9998 "EHLO
	mirapoint5.brutele.be") by vger.kernel.org with ESMTP
	id S932589AbVHOKdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 06:33:05 -0400
Date: Mon, 15 Aug 2005 12:32:52 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: frank nero <m4rcos2003@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: oops in kernel 2.6.11.10
Message-ID: <20050815103252.GA15843@localhost.localdomain>
References: <20050530021313.43231.qmail@web32601.mail.mud.yahoo.com> <2cd57c900508150019544d49ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <2cd57c900508150019544d49ca@mail.gmail.com>
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.9i
X-Junkmail-Status: score=10/50, host=mirapoint5.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090203.43006CAF.001B-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=C0=F5=08=08?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Question, is there a relation with my bug ? See the mail with Oops and
USBStorage ?
> 
> I reply rather late. This problem was solved in v2.6.12, by the patch:
> drop_buffers() oops fix. Thanks.
> 
>         Coywolf

	Stephane
-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>

