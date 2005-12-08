Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVLHO4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVLHO4T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVLHO4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:56:18 -0500
Received: from iona.labri.fr ([147.210.8.143]:65493 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932171AbVLHO4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:56:18 -0500
Message-ID: <4398493E.50508@labri.fr>
Date: Thu, 08 Dec 2005 15:54:54 +0100
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to enable/disable security features on mmap() ?
References: <43983EBE.2080604@labri.fr>	 <1134051272.2867.63.camel@laptopd505.fenrus.org>	 <43984154.5050502@labri.fr>  <43984595.1090406@labri.fr> <1134053349.2867.65.camel@laptopd505.fenrus.org>
In-Reply-To: <1134053349.2867.65.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> well it's a /proc/ variable already! So you can just turn it off
> entirely at runtime. (what is better is that you use the setarch program
> to turn it off for selected programs though...)

I knew it was a stupid question ! I fooled myself once more ! ;-)
I'll take a look at this familly of variables and at the proc entries.

Thanks a lot !
-- 
Emmanuel Fleury

When the gods wish to punish us they answer our prayers.
  -- Oscar Wilde
