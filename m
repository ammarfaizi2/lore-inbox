Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316484AbSFEWx7>; Wed, 5 Jun 2002 18:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316496AbSFEWx6>; Wed, 5 Jun 2002 18:53:58 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:44786 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316484AbSFEWx6>; Wed, 5 Jun 2002 18:53:58 -0400
Subject: Re: Load kernel module automatically
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Wegner <oliver@wilmskamp.dyndns.org>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
In-Reply-To: <200206060023.42180.oliver@wilmskamp.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Jun 2002 00:45:42 +0100
Message-Id: <1023320742.2443.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-05 at 23:23, Oliver Wegner wrote:
> all i wanted to point out was that it doesnt seem to be distribution 
> independent as someone had stated before because that file /etc/modules 
> for example doesnt exist under SuSE. i wasnt asking anything about it 
> myself.
> 
> anyway i will be able to find out that information if i need to sometime. 
> thanks.

modules.conf is the standard name for it. A long time ago it was
sometimes called conf.modules. 


