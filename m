Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263625AbRFTX0W>; Wed, 20 Jun 2001 19:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263674AbRFTX0M>; Wed, 20 Jun 2001 19:26:12 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:55426 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S263625AbRFTXZy>;
	Wed, 20 Jun 2001 19:25:54 -0400
Date: Thu, 21 Jun 2001 02:28:01 +0300 (EEST)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: Rob Landley <landley@webofficenow.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Timur Tabi <ttabi@interactivesi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <0106201412240B.00776@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L2.0106210227420.22568-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


export IFS=$'\n'

> lines=`ls -l | awk '{print "\""$0"\""}'`
> for i in $lines
> do
>   echo line:$i
> done

