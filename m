Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161209AbWALTe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbWALTe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbWALTe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:34:27 -0500
Received: from bno-84-242-95-19.nat.karneval.cz ([84.242.95.19]:48850 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1161209AbWALTe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:34:27 -0500
Message-ID: <43C6AF3D.2030601@gmail.com>
Date: Thu, 12 Jan 2006 20:34:21 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
CC: Jon Mason <jdmason@us.ibm.com>, mulix@mulix.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
References: <20060112175051.GA17539@us.ibm.com> <43C6ADDE.5060904@liberouter.org>
In-Reply-To: <43C6ADDE.5060904@liberouter.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby napsal(a):
> which will be removed soon, I guess. And, additionally, could you change that
> lines to use PCI_DEVICE macro?
plus in alsa driver converting to use macros from pci_ids for devices instead of
numbers.

thanks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
