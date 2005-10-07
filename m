Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVJGMVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVJGMVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 08:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVJGMVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 08:21:16 -0400
Received: from qproxy.gmail.com ([72.14.204.202]:62866 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932417AbVJGMVQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 08:21:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WA3/dhblWAka7MJzdmys2sNKvdaqW8hyZTkpbmTDJsQUg3UXR62t2aT1Vensyj48tS5Ludg65zd+phBwVd9rlmYcKNo9fLJLK5weOiScwR2BaWYh2K8PTm5r3wfVB/xVYOHEIXofm8qbMyhjr4n7QJ/Fs2sL0lsjLAqs9IyM6/I=
Message-ID: <9a8748490510070521g66176c9fv6f371697634143e2@mail.gmail.com>
Date: Fri, 7 Oct 2005 14:21:15 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Mark Gross <mgross@linux.intel.com>
Subject: Re: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Sebastien.Bouchard@ca.kontron.com, mark.gross@intel.com
In-Reply-To: <200510061028.00604.mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510060803.21470.mgross@linux.intel.com>
	 <9a8748490510060952v71927cadj469c912c13f60400@mail.gmail.com>
	 <200510061028.00604.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Mark Gross <mgross@linux.intel.com> wrote:
> On Thursday 06 October 2005 09:52, Jesper Juhl wrote:
> > > +This directory exports the following interfaces.  There opperation is documented

Btw, please spell "operation" correctly :)

[snip]
> > > +  printk(KERN_ERR" misc_register retruns %d \n", ret);

Space between 'KERN_ERR" and '"' please.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
