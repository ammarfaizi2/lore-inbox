Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287480AbRLaKIt>; Mon, 31 Dec 2001 05:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287427AbRLaKIj>; Mon, 31 Dec 2001 05:08:39 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:5253 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287482AbRLaKIY>; Mon, 31 Dec 2001 05:08:24 -0500
Date: Mon, 31 Dec 2001 11:08:13 +0100
Message-Id: <200112311008.fBVA8DP25091@home.geggus.net>
From: Sven Geggus <sven@geggus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: writing device drivers for commercial hardware
Organization: World Domination, fast!
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C2A2BF6.9718.4C5955@localhost> you wrote:

> As I've said, this is a really cheap one, I don't think that it's well-
> known.
> It's from ELV and called 'GSM- und Chipkartenlesegerät', so, it's a 
> German one. Sorry for that.
> But thanks for all your hints and tips. I'll keep on trying.

Wegen diesem teil hab ich schon bei ELV angefragt:

Keinerlei Doku im Gegensatz zu den sonstigen ELV Produkten. Ich nehme an,
dass es sich um Taiwan Schrott handelt, den die selbst nur durchreichen.

Wie die Vorredner schon sagten: Meist braucht man fuer seriell
angeschlossenen Geraete definitiv keinen Kernelreiber. Der vorhandene
Treiber fuer die serielle Schnittstelle reicht aus.

Conrad verkauft ein ebensobilliges Teil von Towitoko, fuer das es
Linuxtreiber gibt (stichwort scez).

Gute Links rund um das Thema Programmierung der seriellen Schnittstelle
unter Linux hat die Homepage eines ganz anderen Projektes:

http://wth.berlios.de

Sven


-- 
"I'm a bastard, and proud of it"
                          (Linus Torvalds, Wednesday Sep 6, 2000)

/me is giggls@ircnet, http://geggus.net/sven/ on the Web
