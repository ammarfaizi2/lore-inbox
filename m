Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129815AbQLLPqd>; Tue, 12 Dec 2000 10:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131523AbQLLPqY>; Tue, 12 Dec 2000 10:46:24 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:21536 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S129815AbQLLPqM>;
	Tue, 12 Dec 2000 10:46:12 -0500
Message-ID: <20001212161544.A2134@win.tue.nl>
Date: Tue, 12 Dec 2000 16:15:44 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Matthias Czapla <dermatsch@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cdrom doesnt work anymore with 2.4
In-Reply-To: <20001212141704.A225@st3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001212141704.A225@st3>; from Matthias Czapla on Tue, Dec 12, 2000 at 02:17:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000 at 02:17:04PM +0100, Matthias Czapla wrote:

> I have a quite old cdrom drive, called Cyberdrive 240D. With linux 2.2.17
> it worked with soemtimes odd behavior, but it worked.
> With 2.4.0-test11 I can mount cdroms in it but if I want to access it (eg.
> ls, cd...) I get messages like:
> _isofs_bmap: block >= EOF (1096810496, 2048)
> or 
> _isofs_bmap: block < 0

Fixed in 2.4.0-test12.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
