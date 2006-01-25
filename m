Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWAYRaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWAYRaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWAYRaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:30:46 -0500
Received: from mail.gmx.de ([213.165.64.21]:16533 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750789AbWAYRap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:30:45 -0500
X-Authenticated: #428038
Message-ID: <43D7B5BE.60304@gmx.de>
Date: Wed, 25 Jan 2006 18:30:38 +0100
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: mrmacman_g4@mac.com, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B075.6000602@gmx.de> <43D7B2DF.nailDFJA51SL1@burner>
In-Reply-To: <43D7B2DF.nailDFJA51SL1@burner>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:

>> So I'll repeat my question: is there anything that SG_IO to /dev/hd* (via
>> ide-cd) cannot do that it can do via /dev/sg*? Device enumeration doesn't count.
> 
> But device enumeration is the central point when implementing -scanbus.

Again: Is there anything *besides* (<German>: auﬂer) device enumeration that
does not work with the current /dev/hd* SG_IO interface?
