Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbSAPSI4>; Wed, 16 Jan 2002 13:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285498AbSAPSIu>; Wed, 16 Jan 2002 13:08:50 -0500
Received: from ns.ithnet.com ([217.64.64.10]:44041 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S285369AbSAPSIb>;
	Wed, 16 Jan 2002 13:08:31 -0500
Date: Wed, 16 Jan 2002 19:08:20 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Frank Jacobberger <f1j@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysv.o and 2.4.18-pre4
Message-Id: <20020116190820.69ed3909.skraw@ithnet.com>
In-Reply-To: <3C45B8BC.4060600@xmission.com>
In-Reply-To: <3C45B8BC.4060600@xmission.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002 10:30:36 -0700
Frank Jacobberger <f1j@xmission.com> wrote:

> Alan Cox stated:
> 
> ac>Please check the archives of the list. The sis_ drm one has been 
> discussed
> 
> sysv hasn't.

No, but the problem has:

Add "EXPORT_SYMBOL(waitfor_one_page);" to kernel/ksyms.c.

(Marcelo)

Regards,
Stephan


