Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVGZERn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVGZERn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 00:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVGZERn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 00:17:43 -0400
Received: from [12.127.34.214] ([12.127.34.214]:54104 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261631AbVGZEQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 00:16:33 -0400
Subject: Re: [PATCH] Add missing tvaudio try_to_freeze.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42E522B4.2080000@brturbo.com.br>
References: <1121659791.13487.74.camel@localhost>
	 <42E522B4.2080000@brturbo.com.br>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1122323285.4674.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 26 Jul 2005 06:28:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-07-26 at 03:34, Mauro Carvalho Chehab wrote:
> Nigel,
> 
> Nigel Cunningham wrote:
> > Hi.
> > 
> > The .c gives Gerd Knorr as the maintainer of this file, but no email
> > address. The MAINTAINERS file doesn't have his name or make it clear who
> > owns the file. I haven't therefore been able to cc the maintainer.
> 
> 	I'm current maintainer of V4L. The patch was tested and it looks ok.

Thanks! Would you consider sending a patch to the maintainers file too?

Regards,

Nigel

> > 
> > Tvaudio lacks a refrigerator call. This patch fixes that.
> > 
> > Regards,
> > 
> > Nigel
> > 
> > Signed-off by: Nigel Cunningham <ncunningham@suspend2.net>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

