Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319239AbSHNIA1>; Wed, 14 Aug 2002 04:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319240AbSHNIA1>; Wed, 14 Aug 2002 04:00:27 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:7952 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S319239AbSHNIA0>; Wed, 14 Aug 2002 04:00:26 -0400
Message-Id: <200208140758.g7E7wBp15027@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Peter Chubb <peter@chubb.wattle.id.au>, "Jim Roland" <jroland@roland.net>,
       Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: RE:Re: The spam problem.
Date: Wed, 14 Aug 2002 10:55:09 -0200
X-Mailer: KMail [version 1.3.2]
Cc: <Hell.Surfers@cwctv.net>, <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
References: <15704.7035.97347.606927@wombat.chubb.wattle.id.au>
In-Reply-To: <15704.7035.97347.606927@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 August 2002 18:32, Peter Chubb wrote:
> >>>>> "Jim" == Jim Roland <jroland@roland.net> writes:
>
> Jim> Now there's a good thought!  Post, Confirm, gets posted.  If
> Jim> member, no confirmation necessary.
>
> It'd be impractical because you'd need to merge not only the people
> directly on the list as members, but also the people who get LKML as
> digest via Dell, as news, or via a mail exploder.

It may be very nice to ask confirmation for suspicious posts only.
Filter can discriminate messages into:

1.Obvious spam: drop on the floor
2.Possible spam: ask sender to confirm
  (with reason why robot thinks it may be a spam)
3.Not a spam: post without confirmation

This avoids problems with good messages being lost
and does not require human admins to read the messages.
--
vda
