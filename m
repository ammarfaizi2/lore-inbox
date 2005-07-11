Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVGKX0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVGKX0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 19:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVGKXYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 19:24:25 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:19664 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S261818AbVGKXX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 19:23:57 -0400
Subject: Re: [openib-general] [PATCH 26/29v2] Add kernel portion of user CM
	implementation
From: Hal Rosenstock <halr@voltaire.com>
To: Tom Duffy <tduffy@sun.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <1121116768.3028.9.camel@duffman>
References: <1121110427.4389.5036.camel@hal.voltaire.com>
	 <1121116768.3028.9.camel@duffman>
Content-Type: text/plain
Organization: 
Message-Id: <1121123772.4389.5061.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 19:16:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 17:19, Tom Duffy wrote:
> On Mon, 2005-07-11 at 16:59 -0400, Hal Rosenstock wrote:
> > Add kernel portion of user CM implementation
> 
> Hal, does this compile?  As it doesn't seem to include the patch I sent
> to openib-general changing class_simple to class, I don't think it
> should work on 2.6.13-rc.

I did compile and build things at each step along the way. I must have
missed some changes with 2.6.13-rc.

> [ also, in future patch bombs, could you please set the references
> header so that the message thread properly, thanks ]

How do I do this ?

-- Hal

