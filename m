Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWC0Hua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWC0Hua (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 02:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWC0Hua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 02:50:30 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:16005 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1750796AbWC0Hua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 02:50:30 -0500
Message-ID: <44279943.9000207@bootc.net>
Date: Mon, 27 Mar 2006 08:50:27 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5 (X11/20060309)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Gustavo_Guillermo_P=E9rez?= <gustavo@compunauta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amdtp driver removed? wich should be handle FireWire CDROM cases?
References: <200603261558.27583.gustavo@compunauta.com>
In-Reply-To: <200603261558.27583.gustavo@compunauta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo Guillermo Pérez wrote:
> Seeing the changelog I realized the amdtp driver I was being used to handle a 
> Firewire External HD/CD case was removed.
> 
> Is there any replacement or the driver is unmantained?.

Shouldn't it just work with sbp2?

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
