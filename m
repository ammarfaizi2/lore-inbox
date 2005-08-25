Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVHYKqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVHYKqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 06:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVHYKqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 06:46:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11401 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964932AbVHYKqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 06:46:06 -0400
Subject: Re: starting function of keyboard.c in FC2.
From: Arjan van de Ven <arjan@infradead.org>
To: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0508251606170.16200@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0508251606170.16200@lantana.cs.iitm.ernet.in>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 12:45:54 +0200
Message-Id: <1124966754.3222.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 16:10 +0530, P.Manohar wrote:
> 
>     In RH9 the starting function of keyboard.c is handle_scancode,
> this is 
> the function to which the scancode is given by the keyboard interrupt 
> handler, its fine, but in FC2 , this handle_scancode is not there,
> it's 
> functionality is spitted and placed in several functions. What is the 
> starting function of keyboard.c in FC2?
> if anybody knows please suggest on it.

you forgot to mention what you need it for...


