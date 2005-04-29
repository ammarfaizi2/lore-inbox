Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVD2JIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVD2JIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 05:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVD2JIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 05:08:37 -0400
Received: from sophia.inria.fr ([138.96.64.20]:45463 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S262478AbVD2JIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 05:08:35 -0400
Message-ID: <4271F962.6040607@yahoo.fr>
Date: Fri, 29 Apr 2005 11:07:46 +0200
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, linux-joystick@atrey.karlin.mff.cuni.cz,
       Andrew Morton <akpm@osdl.org>
Subject: Re: snd-ens1371 (alsa) & joystick woes
References: <425BACC2.9020709@yahoo.fr> <425F8B09.3010706@yahoo.fr> <200504282212.48456.dtor_core@ameritech.net>
In-Reply-To: <200504282212.48456.dtor_core@ameritech.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (sophia.inria.fr [138.96.64.20]); Fri, 29 Apr 2005 11:07:49 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>Could you check if the following patch from Vojtech fixes it?
>
As I said in http://bugzilla.kernel.org/show_bug.cgi?id=4382 yes it 
fixes the
problem.

Thanks.

-- 
Guillaume


