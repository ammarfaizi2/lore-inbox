Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269174AbRHYNRT>; Sat, 25 Aug 2001 09:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269158AbRHYNRJ>; Sat, 25 Aug 2001 09:17:09 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:5637 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269174AbRHYNQ4>;
	Sat, 25 Aug 2001 09:16:56 -0400
Date: Sat, 25 Aug 2001 10:17:04 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010825094000.O756-100000@gerard>
Message-ID: <Pine.LNX.4.33L.0108251016260.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, Gérard Roudier wrote:

> With such values, given a U160 SCSI BUS, using 64K IO chunks will
> result in about less than 25% of bandwidth used for the SCSI protocol

Unless you donate one of those sets to me, I'm not going
to see decent IO with smaller IO sizes. ;)

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

