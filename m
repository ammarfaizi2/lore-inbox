Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316429AbSETW7G>; Mon, 20 May 2002 18:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316431AbSETW7F>; Mon, 20 May 2002 18:59:05 -0400
Received: from jalon.able.es ([212.97.163.2]:33014 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316429AbSETW7E>;
	Mon, 20 May 2002 18:59:04 -0400
Date: Tue, 21 May 2002 00:58:58 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Robert Love <rml@tech9.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4-ac: more scheduler updates (1/3)
Message-ID: <20020520225858.GA1792@werewolf.able.es>
In-Reply-To: <1021928919.925.314.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.20 Robert Love wrote:
>Alan,
>
>I promise these are the last of them :)
>
>	- remove the RUN_CHILD_FIRST cruft from kernel/fork.c.
>	  Pretty clear this works great; we do not need the ifdefs.

AFAIR, there was a problem with bash, I think.
Is it corrected ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam3 #1 SMP dom may 19 21:07:40 CEST 2002 i686
