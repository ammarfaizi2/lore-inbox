Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbTKFCZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 21:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTKFCZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 21:25:51 -0500
Received: from smtp.uol.com.br ([200.221.11.52]:7351 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S263304AbTKFCZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 21:25:50 -0500
Date: Thu, 6 Nov 2003 00:25:28 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Problems with USB Drive
Message-ID: <20031106022528.GA3636@ime.usp.br>
References: <20031105175609.GA967@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031105175609.GA967@ime.usp.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 05 2003, Rogério Brito wrote:
> Dear developers,
(...)
> Trying to see if the problem would go away with a 2.6 kernel, I
> downloaded 2.6.0-test9 and tried it anyway. The problems still persist.
(...)

Just as some extra information, when I try to shutdown the hotplug
service (via /etc/init.d/hotplug stop), the program hangs and I get
processes in the D state in the output of ps.

Also, when this occurs, lsmod also hangs and is also unkillable.

I am using Debian testing's hotplug, which has version 0.0.20031013-2.


Thanks again for your work, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
