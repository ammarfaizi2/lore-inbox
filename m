Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTLDRUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 12:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTLDRUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 12:20:24 -0500
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:23473 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S263082AbTLDRUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 12:20:23 -0500
Date: Thu, 4 Dec 2003 18:20:16 +0100
From: Guillermo Menguez Alvarez <gmenguez@usuarios.retecal.es>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oom killer in 2.4.23
Message-Id: <20031204182016.5da319d5.gmenguez@usuarios.retecal.es>
In-Reply-To: <Pine.LNX.4.44.0312041801560.26684-100000@gaia.cela.pl>
References: <15498.1070554340@www7.gmx.net>
	<Pine.LNX.4.44.0312041801560.26684-100000@gaia.cela.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, and as a side question, couldn't oom killer be made into a config
> option?

As I see in the ChangeLog:

aa VM merge: page reclaiming logic changes: Kills oom killer

OOM Killer has been removed due to AA VM changes, so maybe it can't be
cleanly enabled again.

Regards,
Guillermo.

-- 
Usuario Linux #212057 - Maquinas Linux #98894, #130864 y #168988
Proyecto LONIX: http://lonix.sourceforge.net
Lagrimas en la Lluvia: http://www.lagrimasenlalluvia.com

