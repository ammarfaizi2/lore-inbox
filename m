Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWA3VCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWA3VCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWA3VCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:02:19 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:37348 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964990AbWA3VCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:02:18 -0500
Message-ID: <43DE7EF7.7080108@tmr.com>
Date: Mon, 30 Jan 2006 16:02:47 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com, "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk> <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr> <43DDFBFF.nail16Z3N3C0M@burner>
In-Reply-To: <43DDFBFF.nail16Z3N3C0M@burner>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Cdrecord is a program that needs to be able to send any SCSI command as 
> it needs to be able to add new vendor unique commands for new drive/feature
> support.

On this we do agree, drive vendors seem to add every new feature with a 
vendor code. Some are NOT required to write CD, but some are needed to 
write "better" CDs, for some definition of better which could mean 
faster, more reliable, special modes, etc.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
