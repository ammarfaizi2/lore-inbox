Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVF0F6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVF0F6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 01:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVF0F6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 01:58:53 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:33983 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261835AbVF0Fw0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:52:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sY7otdR7EqLkZpuFH7R80rNHX30ggz7x9VWzed62WFDc/lH8FVm3mbJbaIZKCVh7eRZBEh06prEyxZK3kV0omRIbgTm2tRozKeQK3x/DfZLhpI8wio/EATA3VcZgSkty80glr4Rfn06e2+nwD8KpHobkkW6VhQjEdxUNS0wPtRM=
Message-ID: <e692861c05062622521a62e73c@mail.gmail.com>
Date: Mon, 27 Jun 2005 01:52:21 -0400
From: Gregory Maxwell <gmaxwell@gmail.com>
Reply-To: Gregory Maxwell <gmaxwell@gmail.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: reiser4 plugins
Cc: David Masover <ninja@slaphack.com>, Hans Reiser <reiser@namesys.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200506270505.j5R55Zsx005315@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ninja@slaphack.com> <42BF4570.9010405@slaphack.com>
	 <200506270505.j5R55Zsx005315@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Wonderful! I carefully "transparently encrypt" my secret files, so
> /everybody/ can read them! Now /that/ is progress!

All of this side feature argument is completely offtopic for the
inclusion of reiser4, but oh well.

In any case, the real use for encrypted files (vs encrypted
partitions) would be for doing things like tying keying into the login
process so that your files are only accessible while you are logged
in.  This would be a very nice feature on a multiuser system.
