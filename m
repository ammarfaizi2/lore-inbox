Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVAZBO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVAZBO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVAZBNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 20:13:38 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:39110 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262265AbVAZBLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 20:11:04 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Nick Pollitt <npollitt@mvista.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Configure mangles hex values 
In-reply-to: Your message of "Tue, 25 Jan 2005 09:25:57 -0800."
             <200501250925.57693.npollitt@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Jan 2005 12:10:46 +1100
Message-ID: <4125.1106701846@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 09:25:57 -0800, 
Nick Pollitt <npollitt@mvista.com> wrote:
>Hello.  I'm thinking that the 0x was stripped for purely cosmetic reasons 
>rather than anything functional.  I had originally thought that the readln 
>function might need the formatting, but taking a closer look at it now I 
>don't see any need.

Agreed.  Apply the patch.

