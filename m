Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbRFFVwt>; Wed, 6 Jun 2001 17:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264188AbRFFVwj>; Wed, 6 Jun 2001 17:52:39 -0400
Received: from jalon.able.es ([212.97.163.2]:49620 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S261685AbRFFVwY>;
	Wed, 6 Jun 2001 17:52:24 -0400
Date: Wed, 6 Jun 2001 23:52:13 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
Message-ID: <20010606235213.C1136@werewolf.able.es>
In-Reply-To: <20010606155026.A28950@bug.ucw.cz> <B74421C0.F6F7%bootc@worldnet.fr> <20010606224203.A2044@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010606224203.A2044@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Wed, Jun 06, 2001 at 22:42:04 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.06 Pavel Machek wrote:
> 
> ACPI is already using 0.1*K, so everything should use that to be
> consistent.
> 								Pavel

Which is the data type for temperature ? Would not it be better to
use 0.01*K ? So you get the full accuracy of a short.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac9 #1 SMP Wed Jun 6 09:57:46 CEST 2001 i686
