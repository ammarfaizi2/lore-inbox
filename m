Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTJJN06 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 09:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTJJN06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 09:26:58 -0400
Received: from mail.native-instruments.de ([217.9.41.138]:22717 "EHLO
	mail.native-instruments.de") by vger.kernel.org with ESMTP
	id S262192AbTJJN05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 09:26:57 -0400
Message-ID: <023501c38f32$2b83caa0$9602010a@jingle>
From: "Florian Schirmer" <jolt@tuxbox.org>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, "David Turner" <novalis@fsf.org>,
       <andrew@mikl.as>, <rob@nocat.net>
References: <1064859766.20847.33983.camel@banks> <1065428944.22491.169.camel@hades.cambridge.redhat.com> <01f301c38f2f$b1a7e0b0$9602010a@jingle> <1065791790.24015.238.camel@hades.cambridge.redhat.com>
Subject: Re: Linksys/Cisco GPL Violations
Date: Fri, 10 Oct 2003 15:26:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I just built the kernel for the WAP54G (wap54g.1.08.tar.gz) and it seems
> to contain only object code for the wireless driver.
>
> In which version did you find the source?

The ethernet and wireless driver where never linked into the kernel. So it
should be okay if they only distribute the module. They decided to provide
object code. Which is far better than a linked the module. I'm aware of the
current discussion wether binary modules are legal or not. The main Linksys
case was about the GPL violation by linking stuff into the kernel. _That_ is
resolved now. The wireless driver is a completely different story. IMHO.

Regards,
   Florian

