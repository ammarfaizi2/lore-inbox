Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286338AbRLTTO3>; Thu, 20 Dec 2001 14:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbRLTTOT>; Thu, 20 Dec 2001 14:14:19 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:63104 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S286338AbRLTTOP>; Thu, 20 Dec 2001 14:14:15 -0500
To: matt@theBachChoir.org.uk, michael.dunsky@p4all.de
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org, scole@lanl.gov
Message-Id: <E16H8p9-00074z-00@DervishD.viadomus.com>
Date: Thu, 20 Dec 2001 20:25:47 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <raul@viadomus.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

>You are close - he uses "MiB" as short for "mebi" - Mega-binary.

    Personally I don't like very much the abbreviations, but I must
recognize that they remove all possible ambiguity for the
Configure.help. With MiB, GiB, etc... you're completely sure that you
are talking about 2^20, 2^30 and not 10^6, 10^9, etc...

    So I think that is a good idea in general to use that
abbreviations for the binary units. Moreover, it's official and
correct use. Eric made a sensible decision here.

    Raúl
