Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbSKAARl>; Thu, 31 Oct 2002 19:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265490AbSKAARi>; Thu, 31 Oct 2002 19:17:38 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.156]:55517 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S265471AbSKAARg>; Thu, 31 Oct 2002 19:17:36 -0500
X-Biglobe-Sender: <t-kouchi@mvf.biglobe.ne.jp>
Date: Thu, 31 Oct 2002 16:23:56 -0800
From: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
To: greg@kroah.com
Subject: Re: bare pci configuration access functions ?
Cc: andrew.grover@intel.com, jung-ik.lee@intel.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021031235457.GF10689@kroah.com>
References: <20021101083717.IAAOC0A82650.6C9EC293@mvf.biglobe.ne.jp> <20021031235457.GF10689@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.04
Message-Id: <20021101092358.JADUC0A8264C.1C79D883@mvf.biglobe.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Oct 2002 15:54:57 -0800
Greg KH <greg@kroah.com> wrote:

> > That's the way ACPI driver designers took and Linux can benefit
> > from other OS's feedback in OS-independent part.
> 
> Can I ask if any of the development for other OSs has actually helped
> Linux development?  I'm just curious.

FreeBSD's acpi project is a good example.
http://www.jp.freebsd.org/acpi/index.html
(though this page doesn't seem to reflect recent status)

They share the same code base (OS-independent part) as Linux
and troubles FreeBSD had are troubles Linux will have or vice versa.

Its mailing-list is based in Japan but most discussions
are in English and some intel developers are also in the list.


AFAIK the aic7xxx driver has similar structure.

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi@cq.jp.nec.com/t-kouchi@mvf.biglobe.ne.jp>

