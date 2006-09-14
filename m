Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWINHcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWINHcn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWINHcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:32:43 -0400
Received: from mx10.go2.pl ([193.17.41.74]:50135 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751347AbWINHcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:32:42 -0400
Date: Thu, 14 Sep 2006 09:36:32 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Message-ID: <20060914073631.GC1640@ff.dom.local>
References: <20060913065010.GA2110@ff.dom.local> <20060913164251.GD13956@redhat.com> <20060914053647.GA1640@ff.dom.local> <20060914063542.GB32642@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914063542.GB32642@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 02:35:42AM -0400, Dave Jones wrote:
...  
> Yes, I understand your patch. What I don't understand is why summit/generic
> have this set so high in the first place.

Sorry for misunderstanding your understanding...
I simply tried to understand another question (how this warning
could be tolerated for all those gits?).

Jarek P.  
