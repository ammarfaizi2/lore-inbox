Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272150AbTGYPGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272138AbTGYPGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:06:12 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:14978 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272144AbTGYPDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:03:49 -0400
Date: Fri, 25 Jul 2003 16:28:48 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307251528.h6PFSmPQ001169@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, zippel@linux-m68k.org
Subject: RE: why the current kernel config menu layout is a mess
Cc: ecki-lkm@lina.inka.de, Fabian.Frederick@prov-liege.be,
       linux-kernel@vger.kernel.org, rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Maybe a completely new, out of kernel tree configurator would be worth
> > thinking about, leaving the in-kernel configurator as a legacy option.
> > I know the config system underwent a major overhaul during 2.5, but I
> > think we could go even further.
>
> Maybe you should look first at something before you throw it away?
> Kconfig is already modular, the Kconfig parser is a library, which you can 
> easily connect to your favourite script language and then you can do with 
> the Kconfig data whatever you want.

Sorry, I meant make the current targets, like menuconfig and xconfig
legacy options, not eliminate the Kconfig parser altogether.

John.
