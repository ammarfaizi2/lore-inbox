Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129344AbRBLREI>; Mon, 12 Feb 2001 12:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbRBLRD6>; Mon, 12 Feb 2001 12:03:58 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:30452 "HELO
	burns.conectiva") by vger.kernel.org with SMTP id <S129344AbRBLRDs>;
	Mon, 12 Feb 2001 12:03:48 -0500
Date: Mon, 12 Feb 2001 15:06:35 -0200 (EST)
From: Fernando Fuganti <fuganti@conectiva.com.br>
To: Paul Powell <moloch16@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Programmatically probe video chipset
In-Reply-To: <20010212164358.2762.qmail@web119.yahoomail.com>
Message-ID: <Pine.LNX.4.21.0102121504220.814-100000@ze.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Feb 2001, Paul Powell wrote:

> Is there an API or other means to determine what video
> card, namely the chipset, that the user has installed
> on his machine?

try kudzu (a hardware detection lib from RedHat) or libdetect (another one
but from Mandrake)
they all provide a reasonable interface and database
 

Fernando Fuganti

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
