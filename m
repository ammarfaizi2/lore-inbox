Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757084AbWKWTVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084AbWKWTVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757443AbWKWTVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:21:51 -0500
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:31436 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1757084AbWKWTVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:21:50 -0500
X-AntiVirus: PTMail-AV 0.3-0.88.6
Subject: Re: [OT] bug? VFAT copy problem
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: "Renato S. Yamane" <renatoyamane@mandic.com.br>,
       The Peach <smartart@tiscali.it>, linux-kernel@vger.kernel.org
In-Reply-To: <87ac2i1ihe.fsf@duaron.myhome.or.jp>
References: <20061120164209.04417252@localhost>
	 <877ixqhvlw.fsf@duaron.myhome.or.jp> <20061120184912.5e1b1cac@localhost>
	 <87mz6kajks.fsf@duaron.myhome.or.jp>
	 <1164204175.10427.1.camel@localhost.localdomain>
	 <20061122145344.GB18141@DervishD> <1164243385.3525.19.camel@monteirov>
	 <20061123091301.GC21908@DervishD> <87hcwq1jg7.fsf@duaron.myhome.or.jp>
	 <45658B19.8010207@mandic.com.br>  <87ac2i1ihe.fsf@duaron.myhome.or.jp>
Content-Type: text/plain; charset=utf-8
Date: Thu, 23 Nov 2006 19:21:47 +0000
Message-Id: <1164309707.21404.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 20:59 +0900, OGAWA Hirofumi wrote:
> . Yes. However, Sergio's windows seems to handle file size more
> than 4GB-1.. 

I not finish my tests yet, but so far I was wrong. 
Could happened that transfer never had pass by one FAT32.

Thanks,  
--
Sérgio M. B. 

