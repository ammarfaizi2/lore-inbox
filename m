Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285073AbSACJUD>; Thu, 3 Jan 2002 04:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285114AbSACJTt>; Thu, 3 Jan 2002 04:19:49 -0500
Received: from t2.redhat.com ([199.183.24.243]:46838 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S285079AbSACJT3>; Thu, 3 Jan 2002 04:19:29 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020103040301.A6936@thyrsus.com> 
In-Reply-To: <20020103040301.A6936@thyrsus.com>  <20020102211038.C21788@thyrsus.com> <20020102174824.A21408@thyrsus.com> <Pine.LNX.4.33.0201030006120.427-100000@Appserv.suse.de> <20020102211038.C21788@thyrsus.com> <3021.1010048894@redhat.com> 
To: esr@thyrsus.com
Cc: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jan 2002 09:19:15 +0000
Message-ID: <4658.1010049555@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  So you're saying the users should be completely lost any time they
> want to use an upated kernel?

Not at all - that's what up2date is for. If I want something newer than the
latest certified erratum release from some vendor with a clue, then I
probably ought to know what I'm doing. 

Making it _easier_ for Aunt Tillie to install something like 2.4.10 is not 
necessarily doing her a favour.

--
dwmw2


