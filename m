Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965267AbVKHTNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965267AbVKHTNT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbVKHTNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:13:19 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:36986 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965267AbVKHTNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:13:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=WAcJY9X6tXQcMjaoIEFz7Rah5/k0401AIg/7zLwRtzd5uLtyGfSwNtiX3zWZ2czKJxzaEBEtKx9Eqhcx/+q0Woga0Vsmyz+q6l/saUwILceOk71Rcp74D4xYKzSRZ3+Jv+P312AqtvoPHBmJaB1J4spwrMpstP9rvd33syF64cg=
Date: Tue, 8 Nov 2005 22:26:42 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] DocBook: allow to mark structure members private
Message-ID: <20051108192642.GA14202@mipter.zuzino.mipt.ru>
References: <20051108183511.GA12043@mipter.zuzino.mipt.ru> <Pine.LNX.4.58.0511081025420.15288@shark.he.net> <20051108190048.GA12240@mipter.zuzino.mipt.ru> <Pine.LNX.4.58.0511081048000.15288@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511081048000.15288@shark.he.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 10:48:56AM -0800, Randy.Dunlap wrote:
> On Tue, 8 Nov 2005, Alexey Dobriyan wrote:
> > P. S.: Is htmldocs broken for someone else?
> >
> >   XMLTO  Documentation/DocBook/wanbook.html
> > XPath error : Undefined variable
> > compilation error: file file:///usr/share/sgml/docbook/xsl-stylesheets-1.66.1/xhtml/docbook.xsl
> > line 114 element copy-of
> > xsl:copy-of : could not compile select expression '$title'
> > XPath error : Undefined variable
> > $html.stylesheet != ''
> >                  ^
> > 		...
> 
> Is that after applying Martin's docbook patches yesterday?
> (I haven't tested that yet.)

Unless they're in a very recent -linus. Probably this is a sign to test
those patches. :-)

