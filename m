Return-Path: <linux-kernel-owner+w=401wt.eu-S1161040AbXAEJ7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbXAEJ7S (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 04:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbXAEJ7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 04:59:18 -0500
Received: from sd291.sivit.org ([194.146.225.122]:3970 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161035AbXAEJ7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 04:59:17 -0500
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
From: Stelian Pop <stelian@popies.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>,
       Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
In-Reply-To: <Pine.LNX.4.61.0701050110170.8556@yvahk01.tjqt.qr>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
	 <1167905384.7763.36.camel@localhost.localdomain>
	 <20070104191512.GC25619@inferi.kami.home>
	 <20070104125107.b82db604.akpm@osdl.org>
	 <1167953784.4901.5.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0701050110170.8556@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 05 Jan 2007 10:59:13 +0100
Message-Id: <1167991153.8985.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 05 janvier 2007 à 01:11 +0100, Jan Engelhardt a écrit :
> On Jan 5 2007 00:36, Stelian Pop wrote:
> >@@ -61,6 +61,7 @@ static struct acpi_driver sony_acpi_driv
> > 
> > static acpi_handle sony_acpi_handle;
> > static struct proc_dir_entry *sony_acpi_dir;
> >+static struct acpi_device *sony_acpi_acpi_device = NULL;
> 
> acpi_acpi?

Yeah, maybe Mattia will have more imagination than I at naming
variables :)

-- 
Stelian Pop <stelian@popies.net>

