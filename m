Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTKDWyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTKDWyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:54:52 -0500
Received: from ns.schottelius.org ([213.146.113.242]:22179 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S261332AbTKDWyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:54:51 -0500
Date: Tue, 4 Nov 2003 23:55:05 +0100
From: Nico Schottelius <nico-linux-kernel@schottelius.org>
To: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI: no battery information
Message-ID: <20031104225505.GA17876@schottelius.org>
References: <20031104123012.GC8062@schottelius.org> <20031104141846.GA22067@finwe.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031104141846.GA22067@finwe.eu.org>
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.0-test4
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek Kawa [Tue, Nov 04, 2003 at 03:18:46PM +0100]:
> Jak podaj? anonimowe ?ród?a, przepowiedziano, ?e Nico Schottelius napisze:
> 
> > Hello!
> > I am using 2.6.0test9 and I have an empty /proc/acpi/battery dir:
> > 
> > scice:/usr/src/linux# ls /proc/acpi/battery/
> > scice:/usr/src/linux#
> 
> Although I'm not using that information, I believe it can be found
> under /sys now.

I have /sys as sysfs here, but in firmware/acpi/... are only
empty directories.

Nico
