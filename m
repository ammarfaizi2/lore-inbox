Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbUBXQOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbUBXQOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:14:46 -0500
Received: from smtp1.xs4all.be ([195.144.64.135]:59312 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S262270AbUBXQOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:14:24 -0500
From: Bart Janssens <bart.janssens@polytechnic.be>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: OOPS: ext3 on 2.6.3 with high IO
Date: Tue, 24 Feb 2004 17:13:58 +0100
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402231202.17307.bart.janssens@polytechnic.be> <20040223150257.18e8d4d5.akpm@osdl.org>
In-Reply-To: <20040223150257.18e8d4d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402241714.01441.bart.janssens@polytechnic.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 February 2004 00:02, Andrew Morton wrote:
> The fact that this happens when you're doing something which thousands
> of other people do makes me wonder.  Is the oops always the same?  Are
> you sure the hardware is good?

I have not saved the other 2 oopses. All I remember is that they were also in 
kjournald. I have tried to make my machine crash again, but I have had no 
luck so far. I will post a new oops if it happens again. The same machine 
(minus the HD) was very stable on 2.4 and using ext2, but I have switched to 
2.6 and ext3 when I bought the 80GB HD.

regards,

-- 
Bart Janssens
