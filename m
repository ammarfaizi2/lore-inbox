Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273330AbRINHeY>; Fri, 14 Sep 2001 03:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273331AbRINHeO>; Fri, 14 Sep 2001 03:34:14 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:5648 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S273330AbRINHdz>;
	Fri, 14 Sep 2001 03:33:55 -0400
Date: Fri, 14 Sep 2001 04:34:47 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Chris Vandomelen <chrisv@b0rked.dhs.org>, linux-kernel@vger.kernel.org,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Athlon bug stomping #2
In-Reply-To: <m1d74utj41.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.4.21.0109140430540.2204-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Sep 2001, Eric W. Biederman wrote:

> Anyone want to generate a kernel patch so this fix can get some wider
> testing?

I'll try to isolate the single bit in the register that is causing the
fault and will send the diff.

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

