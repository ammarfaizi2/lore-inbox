Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbTKZSNi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbTKZSNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:13:38 -0500
Received: from tweedy.ksc.nasa.gov ([128.217.76.165]:18627 "EHLO
	tweedy.ksc.nasa.gov") by vger.kernel.org with ESMTP id S264264AbTKZSNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:13:37 -0500
Subject: Re: kernel 2.4-22 won't compile...
From: Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
To: rgx <rgx@gmx.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200311261749.12545.rgx@gmx.de>
References: <200311261734.23177.rgx@gmx.de>
	 <1069865010.9694.120.camel@tweedy.ksc.nasa.gov>
	 <200311261749.12545.rgx@gmx.de>
Content-Type: text/plain
Message-Id: <1069870412.25657.6.camel@tweedy.ksc.nasa.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 26 Nov 2003 13:13:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-26 at 11:49, rgx wrote:
> > Did you 'make oldconfig'?
> 
> Yes, sure :) The NLS_DEFAULT... is not defined for some reason... 
> I could replace it with the needed content in the source code if I knew its 
> format...


Sorry, had to ask.

My 2.4.20 .config defines:

CONFIG_NLS_DEFAULT="iso8859-1"





