Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267047AbSL3SpL>; Mon, 30 Dec 2002 13:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbSL3SpG>; Mon, 30 Dec 2002 13:45:06 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:27309 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id <S267047AbSL3SpD>; Mon, 30 Dec 2002 13:45:03 -0500
Message-ID: <32797.62.98.199.18.1041274402.squirrel@webmail.roma2.infn.it>
Date: Mon, 30 Dec 2002 19:53:22 +0100 (CET)
Subject: Re: Indention - why spaces?
From: "Emiliano Gabrielli" <emiliano.gabrielli@roma2.infn.it>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20021230131725.GA16072@suse.de>
References: <20021230122857.GG10971@wiggy.net>
        <200212301249.gBUCnXrV001099@darkstar.example.net>
        <20021230131725.GA16072@suse.de>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<quote who="Dave Jones">
> On Mon, Dec 30, 2002 at 12:49:33PM +0000, John Bradford wrote:
>  > > Well, I disagree: http://www.wiggy.net/rants/tabsvsspaces.xhtml
>  > In my opinion, indentation in any form is irritating.
>
> The devfs source code is --> that way.
>

IMHO and in my personal projects I use the following indenting rules:

1) use TABs for _indentation_
2) use SPACEs for aligning

here is an exaple:

<tab><tab>if (cond) {
<tab><tab><tab>dosometing;
<tab><tab><tab>printf("This is foo: '%s', and this bar: '%d'",
<tab><tab><tab>       foo, bar);

where tabs are explicitated, while spaces not.


I think this way combines both tab and spaces advantages, allowing each coder
to have its own indentation width, but NEVER destroing the aspect of the code.

This is only my opinion :-P


-- 
Emiliano 'AlberT' Gabrielli

dip. di Fisica
2° Università di Roma "Tor Vergata"


