Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131881AbQLRPz5>; Mon, 18 Dec 2000 10:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131909AbQLRPzk>; Mon, 18 Dec 2000 10:55:40 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:37004 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131881AbQLRPzV>; Mon, 18 Dec 2000 10:55:21 -0500
From: Christoph Rohland <cr@sap.com>
To: Roderich Schupp <rsch@ExperTeam.de>
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au,
        "H. Peter Anvin" <hpa@transmeta.com>
Subject: Re: [PATCH] Make devfs create /dev/shm (was: Re: Trashing ext2 with hdparm) )
In-Reply-To: <200012080852.JAA19341@www1.ExperTeam.de>
Organisation: SAP LinuxLab
Date: 18 Dec 2000 16:23:26 +0100
In-Reply-To: Roderich Schupp's message of "Fri, 08 Dec 2000 09:46:09 +0100"
Message-ID: <qwwr935da8h.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roderich,

On Fri, 08 Dec 2000, Roderich Schupp wrote:
>> And I'll ask again...  If this is now the recommend mount point,
>> can we have devfs create this directory for us?
> 
> C'mon guys, this is just to easy:

Included in 2.4.0-test13-pre3...

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
