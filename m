Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287809AbSA2ALR>; Mon, 28 Jan 2002 19:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSA2ALH>; Mon, 28 Jan 2002 19:11:07 -0500
Received: from mail108.mail.bellsouth.net ([205.152.58.48]:11871 "EHLO
	imf08bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S287809AbSA2AKz>; Mon, 28 Jan 2002 19:10:55 -0500
Subject: Re: Rik van Riel's vm-rmap
From: Louis Garcia <louisg00@bellsouth.net>
To: Robert Love <rml@tech9.net>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <1012263182.817.9.camel@phantasy>
In-Reply-To: <Pine.LNX.4.33L.0201280613510.32617-100000@imladris.surriel.com> 
	<1012262826.1634.1.camel@tiger>  <1012263182.817.9.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 (1.0.1-2) 
Date: 28 Jan 2002 19:14:19 -0500
Message-Id: <1012263259.1634.3.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should I do the rmap patch first?

--Louis

On Mon, 2002-01-28 at 19:12, Robert Love wrote:
> On Mon, 2002-01-28 at 19:07, Louis Garcia wrote:
> > Does this patch work well with Andrew's low-latency patch?
> 
> There will be failed hunks in the VM code (specifically vmscan.c), but
> you can safely ignore them.  So, yes, it works.
> 
> 	Robert Love
> 



