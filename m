Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTIQLOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 07:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbTIQLOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 07:14:11 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:30165 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262655AbTIQLOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 07:14:09 -0400
X-Sender-Authentication: net64
Date: Wed, 17 Sep 2003 13:14:07 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Olivier Galibert <olivier.galibert@limsi.fr>
Cc: marcelo.tosatti@cyclades.com.br, pavel@ucw.cz, alan@lxorguk.ukuu.org.uk,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-Id: <20030917131407.17f767a3.skraw@ithnet.com>
In-Reply-To: <20030916212301.GC17045@m23.limsi.fr>
References: <20030916195345.GB68728@dspnet.fr.eu.org>
	<Pine.LNX.4.44.0309161814410.15569-100000@logos.cnet>
	<20030916212301.GC17045@m23.limsi.fr>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003 23:23:02 +0200
Olivier Galibert <olivier.galibert@limsi.fr> wrote:

> On Tue, Sep 16, 2003 at 06:16:58PM -0300, Marcelo Tosatti wrote:
> > Which card and driver are you using for IO? 3ware?
> 
>   Bus  6, device   2, function  0:
>     SCSI storage controller: Adaptec AIC-7902 U320 (rev 3).
>   Bus  6, device   2, function  1:
>     SCSI storage controller: Adaptec AIC-7902 U320 (#2) (rev 3).
> 

Hello Olivier,

Pretty interesting.
Can you please give 2.4.23-pre4 a short test. I think I can see a remarkable
difference tp 2.4.22 and would like to find confirmation ...

Regards,
Stephan
