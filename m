Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbTFMJXp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 05:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbTFMJXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 05:23:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19376
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265298AbTFMJXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 05:23:43 -0400
Subject: Re: 2.4.21pre8/cs46xx.c and gcc 3.3 problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Boris <boris@boris.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <004001c33090$478c8080$43444218@raiden>
References: <004001c33090$478c8080$43444218@raiden>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055496911.5162.47.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jun 2003 10:35:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-06-12 at 04:11, Boris wrote:
> It seems that gcc 3.3 doesn't like the cs46xx driver and causes and error.
> The quick fix was to change the following lines

The -ac tree has some of the 3.3 fixes in it, this included. Your change
is correct

