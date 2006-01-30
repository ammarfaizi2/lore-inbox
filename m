Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWA3Qfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWA3Qfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWA3Qfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:35:44 -0500
Received: from mail.dvmed.net ([216.237.124.58]:46814 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932370AbWA3Qfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:35:43 -0500
Message-ID: <43DE4055.8090501@pobox.com>
Date: Mon, 30 Jan 2006 11:35:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: matthias.andree@gmx.de, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, acahalan@gmail.com,
       "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk> <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr> <43DDFBFF.nail16Z3N3C0M@burner> <20060130120408.GA8436@merlin.emma.line.org> <43DE3AE5.nail16ZL1UH7X@burner>
In-Reply-To: <43DE3AE5.nail16ZL1UH7X@burner>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Joerg Schilling wrote: > Matthias Andree
	<matthias.andree@gmx.de> wrote: > > >>>Cdrecord is a program that needs
	to be able to send any SCSI command as >>>it needs to be able to add
	new vendor unique commands for new drive/feature >>>support. >>
	>>Right, but evidently it does not need the kernel to invent numbering.
	>>dev=/dev/hdc works today. > > > Maybe, I will need to enforce to use
	official libscg device names in future.... [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> 
>>>Cdrecord is a program that needs to be able to send any SCSI command as 
>>>it needs to be able to add new vendor unique commands for new drive/feature
>>>support.
>>
>>Right, but evidently it does not need the kernel to invent numbering.
>>dev=/dev/hdc works today.
> 
> 
> Maybe, I will need to enforce to use official libscg device names in future....

To burden users with yet another naming policy?

	Jeff



