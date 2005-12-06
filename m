Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVLFNkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVLFNkf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbVLFNke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:40:34 -0500
Received: from web25812.mail.ukl.yahoo.com ([217.146.176.245]:6562 "HELO
	web25812.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932582AbVLFNkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:40:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=J8jvgrsTXpG8fbecc0CgB65mSbd1ju+XuPePLdw/9HKjU2i/R5DYrswk/+wruG7+zgGExdAhUWiAYCENOqjuNccjr61sx+ufiUTKy8MNgy6hYOgIqWE/c6BoGj18KDlYFOsgTLjvRmrDtAGRz52bku/XSiD7nPWhCNxil/IADkk=  ;
Message-ID: <20051206134027.89769.qmail@web25812.mail.ukl.yahoo.com>
Date: Tue, 6 Dec 2005 14:40:27 +0100 (CET)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: nfs unhappiness with memory pressure
To: trond.myklebust@fys.uio.no, theonetruekenny@yahoo.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch linux-2.6.15-fix_sock_allocation.dif seems
to have helped with this issue.

With this patch applied I have been unable to
reproduce the system freezes I was experiencing in
latest 2.6.x kernels when using nfs-root on my
GameCube (24MB RAM).

Thanks,
Albert



	
	
		
______________________________________________ 
Renovamos el Correo Yahoo! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
