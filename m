Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVEBVtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVEBVtn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 17:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVEBVtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 17:49:43 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:3435 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261161AbVEBVtl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 17:49:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=iVWm8NjgXAfVo6swiXWMw7XslA1+Z2i4t//Aj1nW6pzuaQbmmKBR9Y0Hah9Q+2zHmaB6p8piSY9hwpxqGpLx4TXkljYX+sowusJIFptOL4pPpJAw+O9mmOWJ3Y5zNm9F2/pP5Be6+9eaNcHJSF9Gwr3h4e9+LCGbqDRqe906gEQ=
Date: Sat, 30 Apr 2005 23:34:45 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: cloos@jhcloos.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2
Message-Id: <20050430233445.0687e455.diegocg@gmail.com>
In-Reply-To: <20050501222630.2fed0bd7.akpm@osdl.org>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<m31x8q8bc5.fsf@lugabout.cloos.reno.nv.us>
	<20050501222630.2fed0bd7.akpm@osdl.org>
X-Mailer: Sylpheed version 1.9.9+svn (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 1 May 2005 22:26:30 -0700,
Andrew Morton <akpm@osdl.org> escribió:


> Nope.  At any particular point in time the tree I have here has lots of
> problems - failing to compile, crashing, etc.  It takes me from four hours
> to three days just to get a halfway-respectable release out the door.
> 
> So there's no way in which I'd want to make the tree-of-the-minute
> externally available - it would muck people around too much and would cause
> me to get a ton of email about stuff which I'd probably already fixed.

But is not that the whole point of -mm, giving people stuff to test?
Wouldn't it help to test and fix things faster?
