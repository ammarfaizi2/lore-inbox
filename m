Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264905AbSJVSlU>; Tue, 22 Oct 2002 14:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264904AbSJVSkz>; Tue, 22 Oct 2002 14:40:55 -0400
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:40867
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S264895AbSJVSjb>; Tue, 22 Oct 2002 14:39:31 -0400
Message-ID: <3DB59EBC.9010500@rackable.com>
Date: Tue, 22 Oct 2002 11:53:48 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roelf Schreurs <rosc@imc.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: source for 2.4.18-10 (redhat)
References: <3DB55FE9.9060104@imc.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2002 18:45:39.0942 (UTC) FILETIME=[37C84860:01C279FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roelf Schreurs wrote:

> Hi
>
> I'm upgrading to 2.4.18-10 (on redhat 7.3), and therefore need some 
> files.
> On updates.redhat.com I found:
> kernel-2.4.18-10.i686.rpm
> kernel-bigmem-2.4.18-10.i686.rpm
> kernel-debug-2.4.18-10.i686.rpm
> kernel-smp-2.4.18-10.i686.rpm
>
> Do I need kernel-source.2.4.18-10.i686.rpm and 
> kernel-doc-2.4.18-10.i686.rpm and if yes, where do I find it.
> I guess the doc is not too important, but the source seems to be 
> important.
>
  You want kernel-source.2.4.18-10.i386.rpm.  The kernel-source package 
is not compiled so it works just as well on 386 or a Quad P4 Xeon.  The 
only difference is the config file used to compile the kernel. The 
config file can be found in the configs directory in the kernel source.


BTW- kernel-2.4.18-17.7.x is redhat's current eratta kernel.  In 
addition your downloads may be a bit faster if you use a mirror.
http://www.redhat.com/download/mirror.html

