Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272453AbTHEKVA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 06:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272478AbTHEKVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 06:21:00 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:51849 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272453AbTHEKU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 06:20:59 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 12:20:56 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: marcelo@conectiva.com.br, green@namesys.com
Subject: Re: decoded problem in 2.4.22-pre10
Message-Id: <20030805122056.77fee0bd.skraw@ithnet.com>
In-Reply-To: <20030805100040.079b1b24.skraw@ithnet.com>
References: <20030805100040.079b1b24.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 10:00:40 +0200
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> Hello all,
> 
> the testbox crashed again this night, unfortunately I made a mistake
> yesterday and started vmware once. Although only the usual modules were
> loaded at crash time and not the application, the kernel was tainted of
> course. Nevertheless I present the data:

I re-checked the setup with vmware and found out I can shoot it down in no
time. So you probably should just forget about this bug report, because loading
vmware modules does obviously do harm.

Sorry for bothering you.
Regards,
Stephan

