Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUHMNHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUHMNHj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 09:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbUHMNHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 09:07:39 -0400
Received: from the-village.bc.nu ([81.2.110.252]:10969 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265248AbUHMNHd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 09:07:33 -0400
Subject: Re: Two problems with 2.6.8-rc4-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ismail =?ISO-8859-1?Q?d=F6nmez?= <ismail.donmez@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <2a4f155d0408130401112dad3a@mail.gmail.com>
References: <2a4f155d0408130401112dad3a@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1092398631.24408.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 13:03:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-13 at 12:01, ismail dönmez wrote:
> Probing IDE interface ide2...
> ide2: Wait for ready failed before probe !
> Probing IDE interface ide3...
> ide3: Wait for ready failed before probe !
> Probing IDE interface ide4...
> ide4: Wait for ready failed before probe !
> Probing IDE interface ide5...
> ide5: Wait for ready failed before probe !

This is debug stuff. In the latest ide patch I turned them to
KERN_DEBUG.

