Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264024AbTE3VIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 17:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTE3VIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 17:08:43 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15838
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264024AbTE3VIm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 17:08:42 -0400
Subject: Re: Linux 2.4.21-rc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysiek Taraszka <dzimi@pld.org.pl>
Cc: Santiago Garcia Mantinan <manty@manty.net>,
       Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <200305302255.58353.dzimi@pld.org.pl>
References: <200305261400.h4QE00JF009630@green.mif.pg.gda.pl>
	 <20030526175354.GA4051@man.beta.es>  <200305302255.58353.dzimi@pld.org.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1054326226.23566.59.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 May 2003 21:23:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-30 at 21:55, Krzysiek Taraszka wrote:
> Dnia pon 26. maja 2003 19:53, Santiago Garcia Mantinan napisał:
> > The patch Andrzej sent only solves part of the problem, I can still see
> > this:

You have to fix up things like the CMD640 dependancies too. I've actually 
been hacking on this today too. I'll upload a new -ac with the stuff so
far which seems to work if people want to hack on it too


