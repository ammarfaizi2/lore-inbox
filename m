Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286235AbRLJNn1>; Mon, 10 Dec 2001 08:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286261AbRLJNnR>; Mon, 10 Dec 2001 08:43:17 -0500
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:1920 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S286235AbRLJNnJ>; Mon, 10 Dec 2001 08:43:09 -0500
Date: Mon, 10 Dec 2001 14:42:55 +0100
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: mcrypt hanged my 2.4.16
Message-ID: <20011210144255.A590@localhost.localdomain>
In-Reply-To: <20011210140503.A568@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011210140503.A568@localhost.localdomain>; from jpopl@interia.pl on Mon, Dec 10, 2001 at 02:05:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 02:05:03PM +0100, Jacek Pop³awski wrote:
> I will run mcrypt again, and if system hangs I will try to rewrite full
> message.

So it's fully reproductable. 

Invalid operand: 0000
CPU: 0
(...registers...)
Process: mcrypt (pid: 775, stackpage=c57f5000)
(...stack...)
Segmentation Fault

Magic SysRQ doesn't work, I could only push reset.
Please tell me how can I give you more information (if it's needed).
