Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVHCQhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVHCQhN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 12:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVHCQhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 12:37:13 -0400
Received: from compunauta.com ([69.36.170.169]:62089 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S262327AbVHCQhJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 12:37:09 -0400
From: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove support for gcc < 3.2
Date: Tue, 2 Aug 2005 21:08:05 -0500
User-Agent: KMail/1.8
References: <20050731222606.GL3608@stusta.de>
In-Reply-To: <20050731222606.GL3608@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508022108.05391.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Domingo, 31 de Julio de 2005 17:26, escribió:
> This patch removes support for gcc < 3.2 .
> [1] support removed: 2.95, 2.96, 3.0, 3.1
Please keep the 2.95 support I use to use a lot, on not new hardware.
If you have old hardware with not much resources gcc 2.95 works just fine and 
fast, even you build the main kernel on other machine, by compatibility 
issues one or two drivers should be builded a lot of times into the older 
hardware, then we are forced to build gcc 3.4 or something like.

:(

-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
