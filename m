Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319103AbSIDOON>; Wed, 4 Sep 2002 10:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319168AbSIDOON>; Wed, 4 Sep 2002 10:14:13 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:48512 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S319103AbSIDOOM>; Wed, 4 Sep 2002 10:14:12 -0400
Date: Wed, 04 Sep 2002 16:27:00 +0200
From: DervishD <raul@pleyades.net>
Organization: Pleyades
Reply-To: DervishD <raul@pleyades.net>
To: lypanov@kde.org, greg@kroah.com
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry 
 repacement: generic_out_cast)
Cc: martin@uceb.org, linux-kernel@vger.kernel.org
Message-ID: <3D761834.mail1961JC7F3@pleyades.net>
References: <20020723114703.GM11081@unthought.net>
 <3D3E75E9.28151.2A7FBB2@localhost> <20020725052957.GA13523@kroah.com>
 <20020904134836.GA481@ezri.capsi>
In-Reply-To: <20020904134836.GA481@ezri.capsi>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Alexander and Greg :)

>> > By the way: Multiline C Macros are depreached and will not be
>> Why is this?  Is it a C99 requirement?
>afaik its multi line strings that have been deprecated.

    Multiline C macros are not deprecated. In fact, there is nothing
such as 'multiline macros'. Multiline macros are built using the C
escape character, no more, no less, that makes the preprocesor to
ignore the carriage returns.

    Really it's multi line string literals that have been deprecated.

    Raúl
