Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTGFODF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 10:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265003AbTGFODF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 10:03:05 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:63759 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S262358AbTGFODE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 10:03:04 -0400
Date: Mon, 7 Jul 2003 00:17:26 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: shal <shal@free.fr>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Oops in dst_output  function
In-Reply-To: <3F082DC8.1000900@free.fr>
Message-ID: <Mutt.LNX.4.44.0307070016350.623-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003, shal wrote:

> Hello,
> I run a linux-2.5.73-bk5.
> 
> I have a  lot of oops but all finish by call the dst_output function  
> and system freeze after.

Can you try a newer kernel and see if there is still a problem?


- James
-- 
James Morris
<jmorris@intercode.com.au>


