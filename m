Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUJaWla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUJaWla (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 17:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUJaWla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 17:41:30 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:37846 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261672AbUJaWl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 17:41:28 -0500
Message-ID: <41856AF8.8020200@ens-lyon.fr>
Date: Sun, 31 Oct 2004 23:45:12 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Map extra keys on compaq evo
References: <20041031213859.GA6742@elf.ucw.cz>
In-Reply-To: <20041031213859.GA6742@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works great on my Compaq Evo N600c (not 620).

Thanks a lot.
-- 
Brice Goglin
================================================
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
CNRS-ENS Lyon-INRIA-UCB Lyon
France



Pavel Machek wrote:
> Hi!
> 
> Compaq Evo notebooks seem to use non-standard keycodes for their extra
> keys. I workaround that quirk with dmi hook.
> 
> I think that number of such workarounds neccessary should be
> reasonably small (like one for each manufacturer), and therefore this
> would be good thing...
> 								Pavel
