Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTGBUfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTGBUfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:35:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22933
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264478AbTGBUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:35:49 -0400
Subject: Re: gcc 2.95.4 vs gcc 3.3 ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030702141345.GD13653@rdlg.net>
References: <20030702141345.GD13653@rdlg.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057178845.20319.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jul 2003 21:47:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-02 at 15:13, Robert L. Harris wrote:
>   I'm trying to compile the 2.4.21-ac3 kernel for some work machines.
> One of the users is insisting on gcc 3.3 to compile.  Reading the
> web page on www.kernel.org this is recomended against.
> 
>   Perchance is this old news, is the 3.3 compiled kernel going to kill
> something or anything that should be related to users or any bosses?

It should work, some drivers still don't build with it however

