Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264452AbUE3Xar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbUE3Xar (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 19:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbUE3Xar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 19:30:47 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:10281 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264452AbUE3Xaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 19:30:46 -0400
Date: Sun, 30 May 2004 16:38:55 -0700
From: Paul Jackson <pj@sgi.com>
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: makefile fix
Message-Id: <20040530163855.54de8b08.pj@sgi.com>
In-Reply-To: <20040529205109.GA27792@net-ronin.org>
References: <20040529205109.GA27792@net-ronin.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The (( x > y )) syntax looks like ksh stuff,
equivalent to the more widely supported [ x -gt y ].

Your patch looks reasonable to me.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
