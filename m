Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWGLMcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWGLMcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWGLMcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:32:54 -0400
Received: from srvr22.engin.umich.edu ([141.213.75.21]:54942 "EHLO
	srvr22.engin.umich.edu") by vger.kernel.org with ESMTP
	id S1750978AbWGLMcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:32:53 -0400
From: Matt Reuther <mreuther@umich.edu>
Organization: The Knights Who Say... Ni!
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Depmod errors on 2.6.17.4/2.6.18-rc1/2.6.18-rc1-mm1
Date: Wed, 12 Jul 2006 08:41:48 -0400
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200607100833.00461.mreuther@umich.edu> <200607110720.54119.mreuther@umich.edu> <44B3A3A5.5030208@gmail.com>
In-Reply-To: <44B3A3A5.5030208@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607120841.49753.mreuther@umich.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The depmod problems are gone, except for the reiser4 warning about 
generic_file_read. I thought I had the right patch for that, too, but I guess 
not.

Thanks for all the help!
Matt
