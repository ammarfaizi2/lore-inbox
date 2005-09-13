Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbVIMPSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbVIMPSc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVIMPSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:18:32 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:11845 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S932669AbVIMPSb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:18:31 -0400
Date: 13 Sep 2005 17:18:19 +0200
From: Sebastian Fabrycki <cellsan@interia.pl>
Subject: Cpufreq without voltage/freq. tables in ACPI
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-ORIGINATE-IP: 83.16.246.186
IMPORTANCE: Normal
X-MSMAIL-PRIORITY: Normal
X-PRIORITY: 3
X-Mailer: PSE3
Message-Id: <20050913151819.04AC83B7973@poczta.interia.pl>
X-EMID: 8d540acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.
I have laptop with Pentium M Dothan (stepping B0) 1.6GHz. There are no voltage/freq. paris in ACPI available, so i can't use frequency scaling under Linux.

However i can press special button that raises CPU frequency from 600MHz to 1.6GHz. It's above keyboard, with ventilator sign.

So maybe it is possible to detect which version of Dothan B0 i have? There are AFAIK four versions using different voltage/freq. pairs VID#{A,B,C,D}.

I mean: detect which voltages are used after pressing ventilator button and then check which version of VID# it is.

Other case: where do they keep this information? This ventilator button works (almost: i can't switch back to 600MHz), so it must be stored somewhere..

PS. I'm not subscribed to the list, please Cc me.
-- 
Regards
Sebastian


----------------------------------------------------------------------
TOUR DE POLOGNE: oficjalny serwis >>> http://link.interia.pl/f18b5

