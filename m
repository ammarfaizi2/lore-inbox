Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWAAVlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWAAVlj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 16:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWAAVlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 16:41:39 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2508 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932260AbWAAVli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 16:41:38 -0500
Subject: Re: system keeps freezing once every 24 hours / random apps
	crashing
From: Lee Revell <rlrevell@joe-job.com>
To: Mark v Wolher <trilight@ns666.com>
Cc: Folkert van Heusden <folkert@vanheusden.com>,
       Jiri Slaby <xslaby@fi.muni.cz>, Sami Farin <7atbggg02@sneakemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       jesper.juhl@gmail.com, s0348365@sms.ed.ac.uk, mchehab@brturbo.com.br,
       video4linux-list@redhat.com
In-Reply-To: <43B84BC4.6020502@ns666.com>
References: <20051231163414.GE3214@m.safari.iki.fi>
	 <20051231163414.GE3214@m.safari.iki.fi>	<43B6B669.6020500@ns666.com>
	 <43B73DEB.4070604@ns666.com>	<43B7D3BE.60003@ns666.com>
	 <43B7EB99.8010604@ns666.com>	<43B7EB99.8010604@ns666.com>
	 <20060101183832.2BE0222AEE7@anxur.fi.muni.cz>
	 <20060101184916.GE27444@vanheusden.com>	<43B8256C.2060407@ns666.com>
	 <20060101204958.GG27444@vanheusden.com>  <43B84BC4.6020502@ns666.com>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 16:41:35 -0500
Message-Id: <1136151696.13079.83.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-01 at 22:38 +0100, Mark v Wolher wrote:
> I hope some one can comment on these issue's and especially if the
> bttv code has to do with all this ?
> 

I think you've established that the bttv driver is almost certainly the
problem.

Lee

