Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSBFRnY>; Wed, 6 Feb 2002 12:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290715AbSBFRnO>; Wed, 6 Feb 2002 12:43:14 -0500
Received: from dial-up-2.energonet.ru ([195.16.109.101]:12928 "EHLO
	dial-up-2.energonet.ru") by vger.kernel.org with ESMTP
	id <S290713AbSBFRnG>; Wed, 6 Feb 2002 12:43:06 -0500
Date: Wed, 6 Feb 2002 20:46:08 +0000 (GMT)
From: ertzog <ertzog@bk.ru>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Anuradha Ratnaweera <anuradha@gnu.org>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] kernelconf-0.1.2
In-Reply-To: <20020125163213.A1635@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.21.0202062043520.919-100000@dial-up-2.energonet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Therefore my intention was to point you in the direction of
> an although incomplete implementation of a CML2 compiler
> written in C.
> This could give you the possibility to use the well documented
> and by several people already accepted CML2 language, but at the
> same time you had the flexibility to create your own front-end.


Sorry, but I cannot understand, if a new text parser is going to be
written. I tried to compare a parser, written by my self in C and
in lex+yacc. The second was 4 times quicker and 4 times easier to write,
so can I repeat the question:

how syntax is parsed ?

