Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVERNLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVERNLx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVERNLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:11:52 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:45581 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262156AbVERNLc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:11:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m7MZecQ6PEsq5+2E01kWuijgZlxZ0Oif9fTfO9+7pcqEdDsL84F83Gnl4mCJcBRPQibOD5TNbKyTsn0U1rxhcrETPFQ/alAeD4ZSj+RzIfFzs22OKgrKapvDWdhYKSB4SKAZn3nFagIELNv+kUMaIOQ2JrLcy1bpHCsCA08nbeM=
Message-ID: <e3126c290505180611620380cc@mail.gmail.com>
Date: Wed, 18 May 2005 18:41:30 +0530
From: Vaibhav Nivargi <vnivargi@gmail.com>
Reply-To: Vaibhav Nivargi <vnivargi@gmail.com>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Subject: Re: Detecting link up
Cc: Filipe Abrantes <fla@inescporto.pt>, linux-kernel@vger.kernel.org
In-Reply-To: <20050518134031.53a3243a@phoebee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <428B1A60.6030505@inescporto.pt> <20050518134031.53a3243a@phoebee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try looking at the ioctls which mii-tool / ethtool make

regards,
Vaibhav

On 5/18/05, Martin Zwickel <martin.zwickel@technotrend.de> wrote:
> On Wed, 18 May 2005 11:35:12 +0100
> Filipe Abrantes <fla@inescporto.pt> bubbled:
> 
> > Hi all,
> >
> > I need to detect when an interface (wired ethernet) has link up/down.
> > Is  there a system signal which is sent when this happens? What is the
> > best  way to this programatically?
> 
> mii-tool?
> 
> --
> MyExcuse:
> Not enough interrupts
> 
> Martin Zwickel <martin.zwickel@technotrend.de>
> Research & Development
> 
> TechnoTrend AG <http://www.technotrend.de>
> 
> 
>
