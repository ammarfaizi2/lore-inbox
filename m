Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbTH1Mlu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 08:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbTH1Mlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 08:41:50 -0400
Received: from 19.Red-213-97-251.pooles.rima-tde.net ([213.97.251.19]:14493
	"EHLO linalco.com") by vger.kernel.org with ESMTP id S263963AbTH1Mks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 08:40:48 -0400
Date: Thu, 28 Aug 2003 14:44:04 +0200
From: Ragnar Hojland Espinosa <ragnar@linalco.com>
To: David Schwartz <davids@webmaster.com>
Cc: Timo Sirainen <tss@iki.fi>, Jamie Lokier <jamie@shareable.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828124404.GA11988@linalco.com>
References: <1062061038.1459.240.camel@hurina> <MDEHLPKNGKAHNMBLJOLKEEJEFLAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEJEFLAA.davids@webmaster.com>
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 02:56:29AM -0700, David Schwartz wrote:
> 	No two data sets with the same MD5 hash are known. It will be many, many
> years before anyone finds two data sets of the same size with the same MD5
> hash. The odds of having two data sets just happen to have the same MD5 has
> are  infinitesimal.

It can happen.  It happened to me with two gifs.  FWIW.
-- 
Ragnar Hojland - Project Manager
Linalco "Specialists in Linux and Free Software"
http://www.linalco.com Tel: +34-91-5970074 Fax: +34-91-5970083
