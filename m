Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSH1AVg>; Tue, 27 Aug 2002 20:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318009AbSH1AVg>; Tue, 27 Aug 2002 20:21:36 -0400
Received: from dsl-213-023-020-028.arcor-ip.net ([213.23.20.28]:3269 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317517AbSH1AVf>;
	Tue, 27 Aug 2002 20:21:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "chen, xiangping" <chen_xiangping@emc.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Is it possible to use 8K page size on a i386 pc?
Date: Wed, 28 Aug 2002 02:27:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <FA2F59D0E55B4B4892EA076FF8704F550207819D@srgraham.eng.emc.com>
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F550207819D@srgraham.eng.emc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17jqgJ-0002jY-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 August 2002 20:50, chen, xiangping wrote:
> Hi,
> 
> I just wonder how PAGE_SIZE in determined in each architecture? Is it
> possible to use 8k or bigger page size in a i386 PC?

Hi,

It's possible, but we haven't gotten around to implementing it yet ;-)

-- 
Daniel
