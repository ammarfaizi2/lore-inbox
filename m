Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262613AbSJBWaP>; Wed, 2 Oct 2002 18:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262635AbSJBWaP>; Wed, 2 Oct 2002 18:30:15 -0400
Received: from waste.org ([209.173.204.2]:47245 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262613AbSJBWaO>;
	Wed, 2 Oct 2002 18:30:14 -0400
Date: Wed, 2 Oct 2002 17:35:32 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Mircea Ciocan <mirceac@interplus.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Linux iSCSI server implementation
Message-ID: <20021002223532.GE21969@waste.org>
References: <3D99E993.6000203@interplus.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D99E993.6000203@interplus.ro>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 09:29:39PM +0300, Mircea Ciocan wrote:
> 
> 	I adress you this offtopic question, but I know that only here I  
> 	can find a corect and authoritative answer:
> 
> 	Did some of you know a reliable and production ready
> 	implementation of iSCSI server ( host adapter) protocol
> 	because I was able to find only > client software for Linux.

I don't think there are any yet. Most implementations are still playing
catch-up with the RFC, which is still in the draft phase.

There are a couple free target implementations but to the best of my
knowledge they're for early drafts and aren't going to interoperate
with host drivers for more current drafts.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
