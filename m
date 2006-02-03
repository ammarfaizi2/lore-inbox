Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWBCNpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWBCNpQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWBCNpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:45:16 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54945 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750740AbWBCNpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:45:14 -0500
Date: Fri, 3 Feb 2006 14:45:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, James@superbug.co.uk, acahalan@gmail.com,
       "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43E33F55.nail5CA4MZAKZ@burner>
Message-ID: <Pine.LNX.4.61.0602031444010.7991@yvahk01.tjqt.qr>
References: <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz>
 <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk>
 <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr> <43DDFBFF.nail16Z3N3C0M@burner>
 <20060130120408.GA8436@merlin.emma.line.org> <43DE3AE5.nail16ZL1UH7X@burner>
 <43DE4055.8090501@pobox.com> <43DE42DD.nail2AM41DPRR@burner>
 <Pine.LNX.4.61.0602011601420.22529@yvahk01.tjqt.qr> <43E0E950.nail46349AMDL@burner>
 <Pine.LNX.4.61.0602021715120.13212@yvahk01.tjqt.qr> <43E33F55.nail5CA4MZAKZ@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> So @ is equal to 0,0,0 or 0,0?
>
>":@" is a shorthand for ":@,0" which is a shorthand for ":@0,0" 
>
>There are cases where you may like to use e.g. ":@,3"
>

So, since Linux currently does not have anything but ":@,0" per device 
(device file)...


Jan Engelhardt
-- 
