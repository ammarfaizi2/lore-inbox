Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293317AbSBYQSl>; Mon, 25 Feb 2002 11:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291450AbSBYQSb>; Mon, 25 Feb 2002 11:18:31 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:41450 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S289833AbSBYQSX>; Mon, 25 Feb 2002 11:18:23 -0500
Date: Mon, 25 Feb 2002 17:17:40 +0100
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, fernando@quatro.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-ID: <20020225161740.GZ13774@os.inf.tu-dresden.de>
Mail-Followup-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, fernando@quatro.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020225131923.GY13774@os.inf.tu-dresden.de> <140880104.1014622324@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <140880104.1014622324@[10.10.2.3]>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Feb 25, 2002 at 07:32:05 -0800, Martin J. Bligh wrote:
> So if you comment out the unmask and the whole if clause
> below it, does your system then boot, or do you just crash
> and burn a few lines later?

I just spits out some (not all) chars from the following printk and then
dies.



Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org
