Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbQLVRoy>; Fri, 22 Dec 2000 12:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130272AbQLVRoe>; Fri, 22 Dec 2000 12:44:34 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:23048 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S129842AbQLVRo1>; Fri, 22 Dec 2000 12:44:27 -0500
Date: Fri, 22 Dec 2000 18:13:59 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: FAIL: 2.2.18 + AA-VM-global-7 + serial 5.05
Message-ID: <20001222181359.A2616@burns.e-technik.uni-dortmund.de>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001222154757.A1167@emma1.emma.line.org> <20001222162159.A29397@athlon.random> <20001222173538.A12949@krusty.e-technik.uni-dortmund.de> <00c301c06c38$814ab860$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00c301c06c38$814ab860$294b82ce@connecttech.com>; from stuartm@connecttech.com on Fri, Dec 22, 2000 at 11:59:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2000, Stuart MacDonald wrote:

> What file does step 3 modify? It's likely this patch is being overwritten
> (lost) in step 4. Probably not the source of the problem though.

No, it's not being overwritten, but it's most likely not the source of
the problem.

Permissions have been fixed, sorry for the inconvenience.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
