Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbTHZQhm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTHZQhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:37:42 -0400
Received: from fep02.swip.net ([130.244.199.130]:51356 "EHLO
	fep02-svc.swip.net") by vger.kernel.org with ESMTP id S262743AbTHZQhk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:37:40 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Bas Mevissen <ml@basmevissen.nl>
Subject: Re: 2.6.0-test4 and /etc/modules.conf
Date: Tue, 26 Aug 2003 18:37:42 +0200
User-Agent: KMail/1.5.3
References: <200308252332.46101.cijoml@volny.cz> <200308261748.20002.cijoml@volny.cz> <3F4B8434.80703@basmevissen.nl>
In-Reply-To: <3F4B8434.80703@basmevissen.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308261837.42252.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne út 26. srpna 2003 18:00 jste napsal(a):
> Michal Semler (volny.cz) wrote:
> > Hi,
> >
> > I have in /etc/modules.conf defined which modules to use. 2.4.22 uses it
> > well, but 2.6.0-test4 doesn't.
> >
> > I tried add these defs into /etc/modprobe.d/aliases but without success.
>
> In 2.6, the file /etc/modprobe.conf is used. When you use Red Hat, you
> can install their modutils package from RawHide, that creates that file
> from your /etc/modules.conf file.

Hmm I use Debian - is there any util for this distro?

>
> There is probably some util around that creates the file for you. This
> issue is documented in the FAQ in the modutils source.
>
>  > When I by hand call for example modprobe hid module is loaded and
>  > device works.
>
> This means that you already got the proper modutils version installed.
>
> Regards,
>
> Bas.

