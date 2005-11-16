Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbVKPVRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbVKPVRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVKPVRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:17:25 -0500
Received: from web34108.mail.mud.yahoo.com ([66.163.178.106]:50846 "HELO
	web34108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932609AbVKPVRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:17:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XApZOV8lL7zlgW1Q4L4o+0RQfK/9AQvoYo+DBTasYqvS3ZIDEo1h9zpdq6rxvVafUYcHwj5XBUC4ZfYONZP3JszkKJtHHyMHwxmmjhExYdnEuOdZrlDwV8iIuZWwo9Bx664do4i6ECnke2MR1zMBuuPHAw4qmT8kBM3QdWrJeu0=  ;
Message-ID: <20051116211724.35519.qmail@web34108.mail.mud.yahoo.com>
Date: Wed, 16 Nov 2005 13:17:24 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1132175392.8811.49.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> Is this NFSv2?
> 
> Cheers,
>   Trond
> 

Not according to mount(1): 
 (rw,vers=3,tcp,rsize=32768,wsize=32768,hard,intr,addr=x.x.x.x)

-Kenny





		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
