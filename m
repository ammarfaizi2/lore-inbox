Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbVI3Ph6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbVI3Ph6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVI3Ph6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:37:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13509 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030337AbVI3Ph5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:37:57 -0400
Date: Fri, 30 Sep 2005 08:37:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: New and bogus(!) warning produced by sparse.
In-Reply-To: <Pine.LNX.4.64.0509300727450.3378@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0509300837230.3378@g5.osdl.org>
References: <Pine.LNX.4.60.0509301459020.23217@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.64.0509300727450.3378@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Sep 2005, Linus Torvalds wrote:
> 
> I see why it happens, will fix sparse momentarily 

Fixed, pushed out.

		Linus
