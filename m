Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTLDOhf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 09:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTLDOhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 09:37:35 -0500
Received: from viriato1.servicios.retecal.es ([212.89.0.44]:65020 "EHLO
	viriato1.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S261868AbTLDOhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 09:37:34 -0500
Date: Thu, 4 Dec 2003 15:37:32 +0100
From: Guillermo Menguez Alvarez <gmenguez@usuarios.retecal.es>
To: Con Kolivas <kernel@kolivas.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-ck1
Message-Id: <20031204153732.555c5a49.gmenguez@usuarios.retecal.es>
In-Reply-To: <200312050108.15839.kernel@kolivas.org>
References: <200312040228.44980.kernel@kolivas.org>
	<Pine.LNX.4.53.0312041421300.9854@gockel.physik3.uni-rostock.de>
	<200312041436.57450.tvrtko@croadria.com>
	<200312050108.15839.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Probably just a whitespace problem. Try this one. Please tell me if it
> works; I just made this based on what Tim sent (thanks muchly by the
> way Tim!)

Patched correctly, seems to work fine:

cpu  1247 0 891 14492
cpu0 1247 0 891 14491

Thank you both :)

-- 
Usuario Linux #212057 - Maquinas Linux #98894, #130864 y #168988
Proyecto LONIX: http://lonix.sourceforge.net
Lagrimas en la Lluvia: http://www.lagrimasenlalluvia.com

