Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312077AbSCRAoQ>; Sun, 17 Mar 2002 19:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312148AbSCRAoG>; Sun, 17 Mar 2002 19:44:06 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:59402 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S312077AbSCRAoB>; Sun, 17 Mar 2002 19:44:01 -0500
Message-ID: <3C95384A.99FB9C63@linux-m68k.org>
Date: Mon, 18 Mar 2002 01:43:54 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: alternative linux configurator prototype v0.2
In-Reply-To: <3C9396F5.7319AB27@linux-m68k.org> <3C94948E.777B5BAF@linux-m68k.org> <20020317233830.GA2679@werewolf.able.es>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"J.A. Magallon" wrote:

> There is something (as an 'external' viewer) I never understood.
> Why nobody has taken the 'obvious' way ?
> - Perl is much more extended that python and better? than sh for CML.

Because we should get away from a language, what we need are properties.
E.g. a driver has dependencies on other parts of the kernel or has
configuration options and these properties should be expressed as clear
as possible.

bye, Roman
