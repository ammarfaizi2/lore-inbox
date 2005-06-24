Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVFXNnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVFXNnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 09:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVFXNnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 09:43:05 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:60045 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262506AbVFXNl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 09:41:57 -0400
Message-ID: <42BC0DCD.8020206@g-house.de>
Date: Fri, 24 Jun 2005 15:42:37 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>
Subject: Re: [ANNOUNCE] ORT - Oops Reporting Tool
References: <42BBE593.9090407@trex.wsi.edu.pl>
In-Reply-To: <42BBE593.9090407@trex.wsi.edu.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micha³ Piotrowski schrieb:
> If you know something about bash scripting you can review it, add some 
> useful features and make some optimalisations. Or just send me an idea.

why does it have to be run as root? the only things i see missing are 
the "Capabilities" output from lspci -vvv when running as a user.

otherwise: great script, could be even included in ../scripts ?

thanks,
Christian.
-- 
BOFH excuse #145:

Flat tire on station wagon with tapes.  ("Never underestimate the 
bandwidth of a station wagon full of tapes hurling down the highway" 
Andrew S. Tannenbaum)
