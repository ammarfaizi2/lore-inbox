Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131560AbRANJwF>; Sun, 14 Jan 2001 04:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131819AbRANJvy>; Sun, 14 Jan 2001 04:51:54 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:42148 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131560AbRANJvn>; Sun, 14 Jan 2001 04:51:43 -0500
To: elenstev@mesatop.com
Cc: Karsten Hopp <Karsten.Hopp@redhat.de>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Linux 2.4.0-ac9
In-Reply-To: <01011318404000.18233@localhost.localdomain>
	<20010114040550.A13315@bochum.redhat.de>
	<01011320473400.00928@localhost.localdomain>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <01011320473400.00928@localhost.localdomain>
Message-ID: <m3n1cuh3vy.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 14 Jan 2001 10:56:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> writes:

> Here is a little patch which also fixes the symptoms of the build
> problem, and makes a kernel 1510 bytes smaller (without
> CONFIG_SWAPFS).  Someone more knowlegable than I will have to verify
> its correctness.

Thanks, this is correct. I did not test the symlink fixes w/o
CONFIG_SWAPFS. My bad.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
