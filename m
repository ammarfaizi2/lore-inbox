Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312484AbSDSONc>; Fri, 19 Apr 2002 10:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312486AbSDSONb>; Fri, 19 Apr 2002 10:13:31 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:57123 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S312484AbSDSONb>; Fri, 19 Apr 2002 10:13:31 -0400
Date: Fri, 19 Apr 2002 16:05:20 +0200
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Cc: jmagallon@able.es, andre@linux-ide.org
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
Message-ID: <20020419140520.GA1687@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, jmagallon@able.es,
	andre@linux-ide.org
In-Reply-To: <Pine.LNX.4.10.10204161720260.10691-100000@master.linux-ide.org> <20020417134004.GA2025@werewolf.able.es> <20020418081152.GA559@chiara.cavy.de> <20020418192728.GA1891@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
User-Agent: Mutt/1.5.0i (Linux 2.4.19-pre7-dsp1 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Apr 18 2002, J.A. Magallon wrote:

> >I also changed '#if 1' to '#if 0' as Andre mentioned but it has no effect,
> >my machine hangs at boot time....

> It worked for me, just booted fine with hdparm included...

I just merged "ide-2.4.19-p7.all.convert.5.patch" into my tree, and now
it works also for me. With former versions my machine hung at boot time,
wether #if 0 or 1 was set.

-- 
# Heinz Diehl, 68259 Mannheim, Germany
