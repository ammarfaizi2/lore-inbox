Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272518AbTHEVxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272846AbTHEVxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:53:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:50365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272518AbTHEVxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:53:13 -0400
Subject: Re: aio: current status
From: Daniel McNeil <daniel@osdl.org>
To: Eduardo =?ISO-8859-1?Q?P=E9rez?= <100018135@alumnos.uc3m.es>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <5bf1952c7ebb0bea68a1503057a2dbc1@alumnos.uc3m.es>
References: <5bf1952c7ebb0bea68a1503057a2dbc1@alumnos.uc3m.es>
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1060120389.14649.31.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Aug 2003 14:53:09 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been testing AIO using Andrew's -mm kernels which includes
many AIO patches.  I've written some copy tests using AIO.

The libaio-0.3.93.tar ball has source to the library and man pages.
What kind of examples are you looking for?

I do not think AIO supports sockets, yet.  I would ask on the
linux-aio mailing list.

There was an interesting paper from the 2003 Linux Symposium on AIO:
http://archive.linuxsymposium.org/ols2003/Proceedings/All-Reprints/Reprint-Pulavarty-OLS2003.pdf


Daniel McNeil <daniel@osdl.org>

On Tue, 2003-08-05 at 07:38, Eduardo Pérez wrote:
> What's the current status of linux-aio?
> 
> Is there any working example using linux-aio?
> 
> Is linux-aio going to support sockets?
> 
> Are there more linux sleeping (or blocking) API calls going to be ported to linux-aio?
> 
> Is there an official home page of linux-aio apart from the outdated:
> http://www.kvack.org/~blah/aio/ ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

