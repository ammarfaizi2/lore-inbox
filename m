Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVCCDTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVCCDTP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVCCCLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:11:10 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:12116 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261376AbVCCCHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:07:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Joshua Hudson <jwhudson@hornet.csc.calpoly.edu>
Subject: Re: Bug report -- keyboard not working Linux 2.6.11 on Inspiron 1150
Date: Wed, 2 Mar 2005 21:07:48 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0503021800350.11832-100000@hornet>
In-Reply-To: <Pine.GSO.4.44.0503021800350.11832-100000@hornet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503022107.48403.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 21:01, Joshua Hudson wrote:
> 
> On Wed, 2 Mar 2005, Dmitry Torokhov wrote:
> 
> > On Wed, 2 Mar 2005 13:26:18 -0800 (PST), Joshua Hudson
> > <jwhudson@hornet.csc.calpoly.edu> wrote:
> > > No obvous reason. Works fine with kernel 2.6.10
> >
> > Does it work with i8042.noacpi kernel boot parameter?
> >
> Yes, it does. I never heard of that option before, or any
> one like it.

It is a new one.

Btw, when it boots _without_ this option is there any messages from
i8042 or ACPI? 

-- 
Dmitry
