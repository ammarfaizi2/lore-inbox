Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319588AbSH3PSZ>; Fri, 30 Aug 2002 11:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319589AbSH3PSZ>; Fri, 30 Aug 2002 11:18:25 -0400
Received: from adsl-nrp3-sao-C8B6CF1E.brdterra.com.br ([200.182.207.30]:57045
	"EHLO tione.haus") by vger.kernel.org with ESMTP id <S319588AbSH3PSY>;
	Fri, 30 Aug 2002 11:18:24 -0400
Date: Fri, 30 Aug 2002 12:22:48 -0300
From: Christoph Simon <ciccio@kiosknet.com.br>
To: linux-kernel@vger.kernel.org
Subject: Re: Compile error with SiS support
Message-Id: <20020830122248.554c1493.ciccio@kiosknet.com.br>
In-Reply-To: <1030720292.3196.49.camel@irongate.swansea.linux.org.uk>
References: <20020830115421.67aaccc7.ciccio@kiosknet.com.br>
	<1030720292.3196.49.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Aug 2002 16:11:32 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > I just tried to compile the kernel 2.4.19 with support for a SiS
> > graphics card. The related options in .config I've set are:
> 
> You need SIS frame buffer support to use SIS DRM

Thanks for your quick reply. You mean I must select?

	Console drivers/Frame-buffer support/SIS acceleration

The help for this option says:

	This is the frame buffer device driver for the SiS 630 and 640
	Super Socket 7 UMA cards. Specs available at www.sis.com.tw.

But this is not my card, which is a SiS 6329.

Thanks again!

I'm not on this list, please CC me.

-- 
Christoph Simon
ciccio@kiosknet.com.br
