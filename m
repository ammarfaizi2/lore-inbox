Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUIMOCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUIMOCs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266802AbUIMOCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:02:48 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:22285 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266807AbUIMOCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:02:45 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Subject: Re: Unwritable device nodes on ro nfs
Date: Mon, 13 Sep 2004 17:02:19 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
References: <200409131551.30187.vda@port.imtp.ilyichevsk.odessa.ua> <41459D0B.404@bio.ifi.lmu.de> <200409131656.52706.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200409131656.52706.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409131702.19931.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 September 2004 16:56, Denis Vlasenko wrote:
> On Monday 13 September 2004 16:13, Frank Steiner wrote:
> > Denis Vlasenko wrote:
> > > Hi,
> > >
> > > I am moving away from devfs. I have a problem
> > > booting with ro nfs root fs.
> >
> > Known problem and the patch is here:
> > http://linux.bkbits.net:8080/linux-2.6/cset@1.1803.129.187
>
> 404 Not Found

I type too fast. It exists, but either my Mozilla or squid
does not like it. Wget works.
--
vda

