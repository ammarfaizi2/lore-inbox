Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbTEHVc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTEHVc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:32:27 -0400
Received: from fmr04.intel.com ([143.183.121.6]:62942 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262135AbTEHVbu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:31:50 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780CCAFDA9@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Daniele Pala'" <dandario@libero.it>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Weird errors for loading modules 
Date: Thu, 8 May 2003 14:43:32 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniele Pala [mailto:dandario@libero.it]
>
> i recently comiled 2.5.69 kernel and all goes fine, 
> except that i'm not able to load modules at
> startup. The error
> it gives is like: "modprobe: ERROR module xyz doesn't 
>  exist in /proc/modules". The same error comes
> out when i try to

Can you actually see the modules in /proc/modules if
you cat it from the shell?

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
