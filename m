Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274817AbTHNRm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275409AbTHNRm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:42:29 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:4555 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S274817AbTHNRm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:42:28 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Thu, 14 Aug 2003 19:42:26 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: green@namesys.com, akpm@osdl.org, andrea@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030814194226.2346dc14.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0308141425460.3360-100000@localhost.localdomain>
References: <20030814084518.GA5454@namesys.com>
	<Pine.LNX.4.44.0308141425460.3360-100000@localhost.localdomain>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003 14:26:33 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> 
> On Thu, 14 Aug 2003, Oleg Drokin wrote:
> 
> > Thank you for all the time and efforts you are putting into finding out
> > the cause.
> 
> Stephan,
> 
> How are things going? Is the machine is still alive and well? 

Hello Marcelo,

the system is up and running, currently:

  7:40pm  up 4 days  2:34,  21 users,  load average: 2.07, 2.10, 2.06

there is still the verification issue, today I added another 50 GB to the data
stream, and therefore got additional 3 verification  errors. But this seems to
have no influence on the stability. Box feels ok, reacts completely normal, no
strange output in any logs.

Regards,
Stephan
