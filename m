Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbRAIU1f>; Tue, 9 Jan 2001 15:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbRAIU10>; Tue, 9 Jan 2001 15:27:26 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:43257 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129774AbRAIU1M>; Tue, 9 Jan 2001 15:27:12 -0500
Date: Tue, 9 Jan 2001 16:39:30 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Bosko Radivojevic <bole@falcon.etf.bg.ac.yu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suser checks in 2.2.x
Message-ID: <20010109163930.C24523@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Bosko Radivojevic <bole@falcon.etf.bg.ac.yu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.0.0.25.0.20010109145610.03b02090@mail.etinc.com> <Pine.LNX.4.20.0101092100320.15661-100000@falcon.etf.bg.ac.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.20.0101092100320.15661-100000@falcon.etf.bg.ac.yu>; from bole@falcon.etf.bg.ac.yu on Tue, Jan 09, 2001 at 09:13:46PM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 09, 2001 at 09:13:46PM +0100, Bosko Radivojevic escreveu:
> I can see there are a lot of suser() checks. When they will be changed
> with appropriate capable(..) checks? Or, will they be changed, at all some
> days?

I assume: as soon as people send patches, I've send two, IIRC, related
to this today. 8)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
