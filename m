Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261988AbSIYOif>; Wed, 25 Sep 2002 10:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbSIYOie>; Wed, 25 Sep 2002 10:38:34 -0400
Received: from gate.in-addr.de ([212.8.193.158]:23571 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S261988AbSIYOib>;
	Wed, 25 Sep 2002 10:38:31 -0400
Date: Wed, 25 Sep 2002 16:33:54 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>,
       Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UP IO-APIC
Message-ID: <20020925143354.GF1102@marowsky-bree.de>
References: <Pine.LNX.4.44.0209240331280.20792-100000@montezuma.mastecende.com> <Pine.GSO.4.33.0209241119500.11624-100000@sweetums.bluetronic.net> <amq996$46e$2@ncc1701.cistron.net> <20020924191934.B2453@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020924191934.B2453@redhat.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-24T19:19:34,
   Benjamin LaHaise <bcrl@redhat.com> said:

> > >APIC makes perfect sense albeit rare.  Single processor IO APICs are very
> > >rare and are usually MP systems with only one processor.
> > I think most AMD Athlon boards have an IO APIC
> I'd love to have it enabled in a distro kernel, but as Arjan pointed out, it 
> currently breaks some laptops if enabled.

Well, _not_ enabling IO-APIC on UP breaks my Athlon / KT333 at home; random
freezes are the result, so I prefer to enable it...

So whichever default is chosen, someone is burned. I hate hardware.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel
Research and Development, SuSE Linux AG
 
``Immortality is an adequate definition of high availability for me.''
	--- Gregory F. Pfister

