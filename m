Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbTEERBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTEERAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:00:44 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:34318 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S263718AbTEEQ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:56:36 -0400
Date: Tue, 6 May 2003 03:09:03 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 660] New: compile failure in net/decnet/dn_route.c
In-Reply-To: <10210000.1052152520@[10.10.2.4]>
Message-ID: <Mutt.LNX.4.44.0305060306370.14338-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003, Martin J. Bligh wrote:

> 
> http://bugme.osdl.org/show_bug.cgi?id=660
> 
>            Summary: compile failure in net/decnet/dn_route.c
>     Kernel Version: 2.5.68-bk11
>             Status: NEW
>           Severity: low
>              Owner: jgarzik@pobox.com
>          Submitter: john@larvalstage.com
> 

This was fixed by Francois Romieu for 2.5.69.

http://marc.theaimsgroup.com/?l=linux-kernel&m=105205431407067&w=2



- James
-- 
James Morris
<jmorris@intercode.com.au>


