Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbRAaLSK>; Wed, 31 Jan 2001 06:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbRAaLRu>; Wed, 31 Jan 2001 06:17:50 -0500
Received: from bastion.power-x.co.uk ([62.232.19.201]:26630 "EHLO
	bastion.power-x.co.uk") by vger.kernel.org with ESMTP
	id <S130017AbRAaLRq>; Wed, 31 Jan 2001 06:17:46 -0500
Date: Wed, 31 Jan 2001 11:18:15 +0000 (GMT)
From: "Dr. David Gilbert" <gilbertd@treblig.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: <ajschrotenboer@lycosmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.1 Detects 64 MB RAM, actual 192MB
In-Reply-To: <200101311057.LAA03114@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.30.0101311117460.20992-100000@springhead.px.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Mikael Pettersson wrote:

> Why on earth is this fairly recent motherboard using BIOS-88
> to report available memory? I would have expected E820 here.
> Can you send the dmesg output from 2.4.0 and/or 2.2.19pre7?

Is it one of these motherboards which has an option setting to select
which type of memory reporting it will do?

Dave

-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert | Work:dg@px.uk.com +44-161-286-2000 Ex258|
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave@treblig.org            http://www.treblig.org         |
\------------------------------------------------------------------/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
