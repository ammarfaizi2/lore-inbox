Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318539AbSH1CQ5>; Tue, 27 Aug 2002 22:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318541AbSH1CQ5>; Tue, 27 Aug 2002 22:16:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11670 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318539AbSH1CQ4>;
	Tue, 27 Aug 2002 22:16:56 -0400
Date: Tue, 27 Aug 2002 22:21:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andre Hedrick <andre@linux-ide.org>
cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.32
In-Reply-To: <Pine.LNX.4.10.10208271814490.24156-100000@master.linux-ide.org>
Message-ID: <Pine.GSO.4.21.0208272219310.6084-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Aug 2002, Andre Hedrick wrote:

> 
> Yep, that has been verified and there are more extentions needed to bring
> up support for all archs.  I will send them to Al and Alan first and post
> them here too shortly I hope.

Please, do.  BTW, could you post the fix for idescsi_setup() messing with
->busy? (separately from "add the missing inlines/defines" patch, that is)

