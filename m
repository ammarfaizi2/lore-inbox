Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbTHZRjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTHZRjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:39:17 -0400
Received: from smtp1.libero.it ([193.70.192.51]:17609 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S261911AbTHZRjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:39:14 -0400
Date: Tue, 26 Aug 2003 19:38:08 +0200
From: Emmanuele Bassi <emmanuele.bassi@infinito.it>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 and /etc/modules.conf
Message-ID: <20030826173808.GC3132@wolverine.lohacker.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200308252332.46101.cijoml@volny.cz> <200308261748.20002.cijoml@volny.cz> <3F4B8434.80703@basmevissen.nl> <200308261837.42252.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200308261837.42252.cijoml@volny.cz>
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-OperatingSystem: Linux 2.6.0-test2-mm1 i686
X-message-flag: Usa un vero mailreader! http://www.mutt.org
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michal Semler (volny.cz) <cijoml@volny.cz>:

Hi,

> > In 2.6, the file /etc/modprobe.conf is used. When you use Red Hat, you
> > can install their modutils package from RawHide, that creates that file
> > from your /etc/modules.conf file.
> 
> Hmm I use Debian - is there any util for this distro?

Inside the module-init-tools package, there's:

/usr/share/doc/module-init-tools/examples/generate-modprobe.conf.gz

Regards,
 Emmanuele.

-- 
Emmanuele Bassi (Zefram)           [ http://digilander.libero.it/ebassi/ ]
GnuPG Key fingerprint = 4DD0 C90D 4070 F071 5738  08BD 8ECC DB8F A432 0FF4
